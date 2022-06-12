import 'package:mportal3_core/mportal3_core.dart';

class Mp3SessionService implements SessionService {
  final SecureStorage secureStorage;
  final SessionDao sessionDao;
  final Mp3Api mp3Api;
  final MerchantsDao merchantsDao;

  const Mp3SessionService({
    required this.secureStorage,
    required this.sessionDao,
    required this.mp3Api,
    required this.merchantsDao,
  });

  @override
  Future<Session> get session async {
    var sessionId = await secureStorage.getSessionId();
    if (sessionId == null || sessionId.isEmpty) {
      throw UnauthorizedException("SessionId doesn't exist");
    }
    var merchantLogin = await secureStorage.getMerchantLogin();
    if (merchantLogin == null || merchantLogin.isEmpty) {
      throw UnauthorizedException("Merchant information doesn't exist");
    }
    var merchant = await mp3Api.fetchMerchantInformation(
      merchantLogin: merchantLogin,
      sessionId: sessionId,
    );
    var session = await sessionDao.getSession(sessionId);
    session = session.copyWith(merchant: merchant);
    return session;
  }

  @override
  Future<String?> get sessionId => secureStorage.getSessionId();
}
