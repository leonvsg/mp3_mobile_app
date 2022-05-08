import 'package:drift/drift.dart';

import '../database.dart';
import '../accessible_merchants_dao.dart';
import '../tables.dart';

part 'drift_accessible_merchants_dao.g.dart';

@DriftAccessor(tables: [AccessibleMerchants])
class DriftAccessibleMerchantsDao extends DatabaseAccessor<AppDb>
    with _$DriftAccessibleMerchantsDaoMixin
    implements AccessibleMerchantsDao {
  DriftAccessibleMerchantsDao(AppDb db) : super(db);

  @override
  Future<List<AccessibleMerchantDto>> getAllAccessibleMerchants() async {
    var result = await select(accessibleMerchants).get();

    return result
        .map(
          (merch) => AccessibleMerchantDto(
            merchantLogin: merch.merchantLogin,
            merchantFullName: merch.merchantFullName,
            merchantType: merch.merchantType,
            sessionTokenHash: merch.session,
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteAllAccessibleMerchants() =>
      delete(accessibleMerchants).go();

  @override
  Future<void> saveAccessibleMerchants(
    List<AccessibleMerchantDto> merchantList,
  ) {
    var list = merchantList.map(
      (mer) => AccessibleMerchant(
        merchantLogin: mer.merchantLogin,
        merchantFullName: mer.merchantFullName,
        merchantType: mer.merchantType,
        session: mer.sessionTokenHash,
      ),
    );

    return batch((batch) => batch.insertAll(accessibleMerchants, list));
  }

  @override
  Future<List<AccessibleMerchantDto>> getAccessibleMerchantsBySession(
    String sessionId,
  ) async {
    var result = await (select(accessibleMerchants)
          ..where((tbl) => tbl.session.equals(sessionId)))
        .get();

    return result
        .map(
          (mer) => AccessibleMerchantDto(
            merchantLogin: mer.merchantLogin,
            merchantFullName: mer.merchantFullName,
            merchantType: mer.merchantType,
            sessionTokenHash: mer.session,
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteAccessibleMerchantsBySession(String sessionId) =>
      (delete(accessibleMerchants)
            ..where(
              (tbl) => tbl.session.equals(sessionId),
            ))
          .go();
}
