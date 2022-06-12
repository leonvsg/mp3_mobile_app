import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:mportal3_core/mportal3_core.dart';

import '../database.dart';
import '../tables.dart';

part 'drift_accessible_merchants_dao.g.dart';

@DriftAccessor(tables: [AccessibleMerchants])
class DriftAccessibleMerchantsDao extends DatabaseAccessor<Mp3Database>
    with _$DriftAccessibleMerchantsDaoMixin
    implements AccessibleMerchantsDao {
  DriftAccessibleMerchantsDao(Mp3Database db) : super(db);

  @override
  Future<void> deleteAllAccessibleMerchants() =>
      delete(accessibleMerchants).go();

  @override
  Future<void> saveAccessibleMerchants({
    required List<AccessibleMerchant> merchants,
    required String sessionId,
  }) {
    final sessionIdHash = md5.convert(utf8.encode(sessionId)).toString();
    final list = merchants.map((model) => _toDto(model, sessionIdHash)).toList();
    return batch((batch) => batch.insertAll(accessibleMerchants, list));
  }

  @override
  Future<List<AccessibleMerchant>> getAccessibleMerchants(
    String sessionId,
  ) {
    final statement = select(accessibleMerchants)
      ..where((tbl) => tbl.session.equals(sessionId));
    return statement.map((dto) => _toModel(dto)).get();
  }

  @override
  Future<void> deleteAccessibleMerchants(String sessionId) =>
      (delete(accessibleMerchants)
            ..where(
              (tbl) => tbl.session.equals(sessionId),
            ))
          .go();

  AccessibleMerchantDto _toDto(
    AccessibleMerchant model,
    String sessionIdHash,
  ) {
    return AccessibleMerchantDto(
      merchantLogin: model.merchantLogin,
      merchantFullName: model.merchantFullName,
      merchantType: model.merchantType.name,
      session: sessionIdHash,
    );
  }

  AccessibleMerchant _toModel(AccessibleMerchantDto dto) {
    var merchantType = MerchantType.unknown;
    try {
      merchantType = MerchantType.values.byName(dto.merchantType);
    } on ArgumentError {
      //TODO: logging
    }

    return AccessibleMerchant(
      merchantLogin: dto.merchantLogin,
      merchantFullName: dto.merchantFullName,
      merchantType: merchantType,
    );
  }
}
