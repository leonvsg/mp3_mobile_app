import 'database.dart';

abstract class AccessibleMerchantsDao {

  Future<List<AccessibleMerchant>> getMerchants();
  Future<void> saveMerchants(List<AccessibleMerchant> merchants);
  Future<void> deleteMerchants();
}