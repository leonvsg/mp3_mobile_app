import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mp3_mobile_app/domain/entities/session.dart';

class SecureStorageDataProvider {
  static const _sessionIdKey = 'sessionId';
  static const _merchantLoginKey = 'merchantLogin';
  static const _sessionKey = 'session';

  final FlutterSecureStorage secureStorage;

  const SecureStorageDataProvider(this.secureStorage);

  Future<void> saveSession(Session session) async {
    //TODO: implement
    throw UnimplementedError();
  }

  Future<Session> getSession() async {
    //TODO: implement
    throw UnimplementedError();
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