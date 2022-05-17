import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:mp3_mobile_app/data/data_sources/db/accessible_merchants_dao.dart';
import 'package:mp3_mobile_app/data/data_sources/db/merchants_dao.dart';
import 'package:mp3_mobile_app/domain/models.dart';

import '../session_dao.dart';
import 'database.dart';
import 'tables.dart';

part 'drift_session_dao.g.dart';

@DriftAccessor(tables: [Sessions, AccessibleMerchants, SessionPermissions])
class DriftSessionDao extends DatabaseAccessor<AppDb>
    with _$DriftSessionDaoMixin
    implements SessionDao {
  final MerchantsDao _merchantsDao;
  final AccessibleMerchantsDao _accessibleMerchantsDao;

  DriftSessionDao(AppDb db, this._merchantsDao, this._accessibleMerchantsDao)
      : super(db);

  @override
  Future<void> deleteAllSessions() {
    return transaction(() async {
      await delete(sessions).go();
      await delete(sessionPermissions).go();
    });
  }

  @override
  Future<void> deleteSession(String sessionId) {
    final sessionIdHash = _getSessionIdHash(sessionId);
    return transaction(() async {
      await (delete(sessions)
            ..where((tbl) => tbl.tokenHash.equals(sessionIdHash)))
          .go();
      await (delete(sessionPermissions)
            ..where((tbl) => tbl.session.equals(sessionIdHash)))
          .go();
    });
  }

  @override
  Future<Session> getSession(String sessionId) async {
    final sessionIdHash = _getSessionIdHash(sessionId);
    final statement = select(sessions)
      ..where((tbl) => tbl.tokenHash.equals(sessionIdHash));
    final sessionDto = await statement.getSingle();
    final accessibleMerchants =
        await _accessibleMerchantsDao.getAccessibleMerchants(sessionId);
    final merchant = await _merchantsDao.getMerchant(sessionDto.merchant);
    final permissions = select(sessionPermissions)
      ..where((tbl) => tbl.session.equals(sessionIdHash));
    return _toModel(
      dto: sessionDto,
      merchant: merchant,
      sessionId: sessionId,
      accessibleMerchants: accessibleMerchants,
      permissions: await permissions.get(),
    );
  }

  @override
  Future<void> saveOrUpdateSession(Session session) {
    return transaction(() async {
      await _merchantsDao.saveOrUpdateMerchant(session.merchant);
      into(sessions).insertOnConflictUpdate(_toDto(session));
      await _accessibleMerchantsDao
          .deleteAccessibleMerchants(session.sessionId);
      await _accessibleMerchantsDao.saveAccessibleMerchants(
        merchants: session.accessibleMerchants,
        sessionId: session.sessionId,
      );
    });
  }

  @override
  Future<void> clearOldSessions(DateTime before) {
    var sessionQuery = select(sessions)
      ..addColumns([sessions.tokenHash])
      ..where((tbl) => tbl.registerTime.isSmallerThanValue(before));
    var accessibleMerchantsDeleteQuery = delete(accessibleMerchants)
      ..where((tbl) => tbl.session.isInQuery(sessionQuery));
    var sessionsDeleteQuery = delete(sessions)
      ..where((tbl) => tbl.registerTime.isSmallerThanValue(before));
    return transaction(() async {
      await accessibleMerchantsDeleteQuery.go();
      await sessionsDeleteQuery.go();
    });
  }

  Session _toModel({
    required SessionDto dto,
    required Merchant merchant,
    required String sessionId,
    required List<AccessibleMerchant> accessibleMerchants,
    required List<SessionPermissionDto> permissions,
  }) {
    return Session(
      sessionId: sessionId,
      userLogin: dto.userLogin,
      merchant: merchant,
      accessibleMerchants: accessibleMerchants,
      permissions: permissions
          .map((dto) => _stringToPermission(dto.permission))
          .toList(),
    );
  }

  SessionDto _toDto(Session model) {
    return SessionDto(
      tokenHash: _getSessionIdHash(model.sessionId),
      userLogin: model.userLogin,
      merchant: model.merchant.login,
      registerTime: DateTime.now(),
    );
  }

  String _getSessionIdHash(String sessionId) {
    return md5.convert(utf8.encode(sessionId)).toString();
  }

  UserPermission _stringToPermission(String str) {
    var permission = UserPermission.unknown;
    try {
      permission = UserPermission.values.byName(str);
    } on ArgumentError {
      //TODO: logging
    }
    return permission;
  }
}
