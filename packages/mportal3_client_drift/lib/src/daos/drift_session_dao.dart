import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:mportal3_client_core/mportal3_client_core.dart';

import '../database.dart';
import '../tables.dart';

part 'drift_session_dao.g.dart';

@DriftAccessor(tables: [Sessions, AccessibleMerchants, SessionPermissions])
class DriftSessionDao extends DatabaseAccessor<AppDb>
    with _$DriftSessionDaoMixin
    implements SessionDao {
  DriftSessionDao(AppDb db) : super(db);

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
        await db.driftAccessibleMerchantsDao.getAccessibleMerchants(sessionId);
    final merchant =
        await db.driftMerchantsDao.getMerchant(sessionDto.merchant);
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
      await db.driftMerchantsDao.saveOrUpdateMerchant(session.merchant);
      into(sessions).insertOnConflictUpdate(_toDto(session));
      await db.driftAccessibleMerchantsDao
          .deleteAccessibleMerchants(session.sessionId);
      await db.driftAccessibleMerchantsDao.saveAccessibleMerchants(
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
