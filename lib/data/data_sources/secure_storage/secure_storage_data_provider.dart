import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageDataProvider {
  static const _sessionIdKey = 'sessionId';
  static const _merchantLoginKey = 'merchantLogin';
  static const _userLoginKey = 'userLogin';

  final FlutterSecureStorage secureStorage;

  const SecureStorageDataProvider(this.secureStorage);

  Future<void> saveUserLogin(String userLogin) async {
    await _saveParam(key: _userLoginKey, value: userLogin);
  }

  Future<String?> getUserLogin() async {
    return await _getParam(_userLoginKey);
  }

  Future<void> saveMerchantLogin(String merchantLogin) async {
    await _saveParam(key: _merchantLoginKey, value: merchantLogin);
  }

  Future<String?> getMerchantLogin() async {
    return await _getParam(_merchantLoginKey);
  }

  Future<void> saveSessionId(String sessionId) async {
    await _saveParam(key: _sessionIdKey, value: sessionId);
  }

  Future<String?> getSessionId() async {
    return await _getParam(_sessionIdKey);
  }

  Future<String?> _getParam(String key) async {
    try {
      return await secureStorage.read(key: key);
    } on PlatformException catch (e, s) {
      rethrow;
    } catch (e, s) {
      rethrow;
    }
  }

  Future<void> _saveParam({required String key, required String value}) async {
    try {
      await secureStorage.write(key: key, value: value);
    } on PlatformException catch (e, s) {
      rethrow;
    } catch (e, s) {
      rethrow;
    }
  }
}