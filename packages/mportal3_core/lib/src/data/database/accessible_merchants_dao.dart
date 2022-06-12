import '../../models.dart';

abstract class AccessibleMerchantsDao {
  Future<List<AccessibleMerchant>> getAccessibleMerchants(String sessionId);
  Future<void> saveAccessibleMerchants({
    required List<AccessibleMerchant> merchants,
    required String sessionId,
  });
  Future<void> deleteAccessibleMerchants(String sessionId);
  Future<void> deleteAllAccessibleMerchants();
}
