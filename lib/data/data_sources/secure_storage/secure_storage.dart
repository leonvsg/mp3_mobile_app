abstract class SecureStorage {
  Future<void> saveUserLogin(String userLogin);
  Future<String?> getUserLogin();
  Future<void> saveMerchantLogin(String merchantLogin);
  Future<String?> getMerchantLogin();
  Future<void> saveSessionId(String sessionId);
  Future<String?> getSessionId();
}