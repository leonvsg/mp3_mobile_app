import 'package:mp3_mobile_app/data/data_sources/db/session_dao.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/auth/auth_request.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/auth/auth_response.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/mapper.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/merchant_information/merchant_information_request.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/merchant_information/merchant_information_response.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/rbs_api.dart';
import 'package:mp3_mobile_app/data/data_sources/secure_storage/secure_storage.dart';
import 'package:mp3_mobile_app/domain/models/session.dart';
import 'package:mp3_mobile_app/domain/exceptions.dart';
import 'package:mp3_mobile_app/domain/repositories/authentication_repository.dart';

import '../error_handler.dart';

class Mp3AuthenticationRepository implements AuthenticationRepository {
  final SessionDao sessionDao;
  final RbsApi apiClient;
  final SecureStorage secureStorage;
  final ErrorHandler errorHandler;

  const Mp3AuthenticationRepository({
    required this.sessionDao,
    required this.apiClient,
    required this.secureStorage,
    required this.errorHandler,
  });

  @override
  Future<Session?> logIn({
    required String login,
    required String password,
  }) async {
    var authResponse = await apiClient.auth(AuthRequest(
      password: password,
      login: login,
    ));
    Session? session;
    if (authResponse is AuthResponseSuccess) {
      var merchantResponse = await apiClient.fetchMerchantInformation(
        MerchantInformationRequest(merchantLogin: authResponse.merchantLogin),
        authResponse.sessionId,
      );
      if (merchantResponse is MerchantInformationResponseSuccess) {
        session = authResponse.toSession(merchantResponse);
        final  sessionId = session.sessionId;
        secureStorage.saveSessionId(sessionId);
        secureStorage.saveMerchantLogin(session.merchant.login);
        secureStorage.saveUserLogin(session.userLogin);
        sessionDao.saveOrUpdateSession(session);
      } else if (merchantResponse is MerchantInformationResponseFail) {
        errorHandler.handleError(merchantResponse.error);
      } else {
        throw RemoteRepositoryException(
          'Unexpected MerchantInformationResponse: ${merchantResponse.toString()}',
        );
      }
    } else if (authResponse is AuthResponseError) {
      errorHandler.handleError(authResponse.error);
    } else {
      throw RemoteRepositoryException(
        'Unexpected AuthResponse: ${authResponse.toString()}',
      );
    }

    return session;
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}
