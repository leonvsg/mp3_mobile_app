import 'package:mp3_client_core/mp3_client_core.dart';
import 'package:mp3_mobile_app/data/data_sources/db/merchants_dao.dart';
import 'package:mp3_mobile_app/data/data_sources/db/session_dao.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/mapper.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/rbs_api.dart';
import 'package:mp3_mobile_app/data/data_sources/secure_storage/secure_storage.dart';

class Mp3SessionRepository implements SessionRepository {
  final SecureStorage secureStorage;
  final SessionDao sessionDao;
  final RbsApi apiClient;
  final MerchantsDao merchantsDao;

  const Mp3SessionRepository(
    this.secureStorage,
    this.sessionDao,
    this.apiClient,
    this.merchantsDao,
  );

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
    var merchantResponse = await apiClient.fetchMerchantInformation(
      MerchantInformationRequest(merchantLogin: merchantLogin),
      sessionId,
    );
    var session = await sessionDao.getSession(sessionId);
    if (merchantResponse is MerchantInformationResponseSuccess) {
      var merchant = merchantResponse.toEntity(merchantLogin);
      session = session.copyWith(merchant: merchant);
    } else if (merchantResponse is MerchantInformationResponseFail) {
      //TODO: handle error
      //throw UnauthorizedException()
    } else {
      throw RemoteRepositoryException(
        'Unexpected MerchantInformationResponse: ${merchantResponse.toString()}',
      );
    }
    return session;
  }

  @override
  Future<String?> get sessionId => secureStorage.getSessionId();
}
