import 'package:drift/drift.dart';

import 'database.dart';

part 'merchants_dao.g.dart';

@DriftAccessor(tables: [Merchants])
class MerchantsDao extends DatabaseAccessor<AppDb> with _$MerchantsDaoMixin {

  MerchantsDao(AppDb db) : super(db);

  Future<List<Merchant>> getMerchants() => select(merchants).get();
  Future<void> deleteMerchants() => delete(merchants).go();
}