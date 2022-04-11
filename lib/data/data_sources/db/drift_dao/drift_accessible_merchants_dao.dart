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
  Future<List<AccessibleMerchant>> getMerchants() => select(accessibleMerchants).get();

  @override
  Future<void> deleteMerchants() => delete(accessibleMerchants).go();

  @override
  Future<void> saveMerchants(List<AccessibleMerchant> merchantList) =>
      batch((batch) => batch.insertAll(accessibleMerchants, merchantList));
}
