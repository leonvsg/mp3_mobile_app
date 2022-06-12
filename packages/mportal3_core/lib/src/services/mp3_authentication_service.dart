import 'package:mportal3_core/mportal3_core.dart';

class Mp3AuthenticationService implements AuthenticationService {
  final Mp3Api mp3api;
  final SecureStorage secureStorage;
  final SessionDao sessionDao;

  const Mp3AuthenticationService({
    required this.mp3api,
    required this.secureStorage,
    required this.sessionDao,
  });

  @override
  Future<Session> logIn({
    required String login,
    required String password,
  }) async {
    final session = await mp3api.auth(login: login, password: password);
    final sessionId = session.sessionId;
    secureStorage.saveSessionId(sessionId);
    secureStorage.saveMerchantLogin(session.merchant.login);
    secureStorage.saveUserLogin(session.userLogin);
    sessionDao.saveOrUpdateSession(session);
    return session;
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}
