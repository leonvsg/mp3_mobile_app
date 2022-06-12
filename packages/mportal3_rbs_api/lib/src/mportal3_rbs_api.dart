import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:mportal3_core/mportal3_core.dart';

import 'dto.dart';

typedef Headers = Map<String, String>;

class Mportal3RbsApi implements Mp3Api {
  static const _acceptedResponseCodes = [200, 400];

  late Headers _headers;

  final String baseUrl;
  final HttpClient httpClient;
  final String referer;

  Mportal3RbsApi(
    this.httpClient,
    this.baseUrl,
    this.referer,
  ) {
    _headers = {
      'Content-Type': 'application/json',
      'Referer': referer,
    };
  }

  @override
  Future<Session> auth({
    required String login,
    required String password,
  }) async {
    final requestBody = AuthRequest(login: login, password: password);
    var response = await httpClient.post(
      '$baseUrl/auth/login',
      requestBody: jsonEncode(requestBody.toJson()),
      additionalHeaders: _headers,
      acceptedResponseCodes: _acceptedResponseCodes,
    );
    final authResponse = AuthResponse.fromJson(jsonDecode(response));
    final Session session;
    if (authResponse is AuthResponseSuccess) {
      final merchant = await fetchMerchantInformation(
        merchantLogin: authResponse.merchantLogin,
        sessionId: authResponse.sessionId,
      );
      return authResponse.toSession(merchant);
    } else if (authResponse is AuthResponseError) {
      //TODO: handle error
      throw RemoteRepositoryException(
        authResponse.error.message,
      );
    } else {
      throw RemoteRepositoryException(
        'Unexpected AuthResponse: ${authResponse.toString()}',
      );
    }
  }

  @override
  Future<Merchant> fetchMerchantInformation({
    required String merchantLogin,
    required String sessionId,
  }) async {
    final requestBody =
        MerchantInformationRequest(merchantLogin: merchantLogin);
    final response = await httpClient.post(
      '$baseUrl/merchant/information',
      requestBody: jsonEncode(requestBody.toJson()),
      additionalHeaders: _getHeadersWithAuth(sessionId),
      acceptedResponseCodes: _acceptedResponseCodes,
    );
    final merchantInformationResponse =
        MerchantInformationResponse.fromJson(jsonDecode(response));
    if (merchantInformationResponse is MerchantInformationResponseSuccess) {
      return merchantInformationResponse.toEntity(merchantLogin);
    } else if (merchantInformationResponse is MerchantInformationResponseFail) {
      //TODO: handle error
      throw RemoteRepositoryException(
        merchantInformationResponse.error.message,
      );
    } else {
      throw RemoteRepositoryException(
        'Unexpected MerchantInformationResponse: ${merchantInformationResponse.toString()}',
      );
    }
  }

  @override
  Future<Order> fetchTransactionDetails({
    required String mdOrder,
    required String sessionId,
  }) async {
    // TODO: implement fetchTransactionDetails
    throw UnimplementedError();

    // final requestBody = TransactionDetailsRequest(mdOrder: mdOrder);
    // final response = await httpClient.post(
    //   '$baseUrl/transaction/details',
    //   requestBody: jsonEncode(requestBody.toJson()),
    //   additionalHeaders: _getHeadersWithAuth(sessionId),
    // );
    // final transactionDetailsResponse =
    //     TransactionDetailsResponse.fromJson(jsonDecode(response));
    // if (transactionDetailsResponse is TransactionDetailsResponseSuccess) {
    //   //TODO: mapping to order
    //   return transactionDetailsResponse.toEntity(mdOrder);
    // } else if (transactionDetailsResponse is TransactionDetailsResponseFail) {
    //   //TODO: handle error
    //   throw RemoteRepositoryException(
    //     transactionDetailsResponse.error.message,
    //   );
    // } else {
    //   throw RemoteRepositoryException(
    //     'Unexpected TransactionDetailsResponse: ${transactionDetailsResponse.toString()}',
    //   );
    // }
  }

  @override
  Future<List<SimpleOrderData>> fetchTransactionList({
    required OrdersSearchFilter filter,
    required String sessionId,
    required int count,
    required int startIndex,
    String? merchantLogin,
  }) async {
    final searchParameters = TransactionSearchParameters.fromEntity(filter);
    final requestBody = TransactionListRequest(
      search: searchParameters,
      nextPage: TransactionSearchPage(
        count: count,
        startIndex: startIndex,
      ),
      merchantLogin: merchantLogin,
    );
    final response = await httpClient.post(
      '$baseUrl/transaction/list',
      requestBody: jsonEncode(requestBody.toJson()),
      additionalHeaders: _getHeadersWithAuth(sessionId),
    );
    final transactionListResponse =
        TransactionListResponse.fromJson(jsonDecode(response));
    if (transactionListResponse is TransactionListResponseSuccess) {
      return transactionListResponse.list
          .map((transactionListItem) => transactionListItem.toEntity())
          .toList();
    } else if (transactionListResponse is TransactionListResponseFail) {
      //TODO: handle error
      throw RemoteRepositoryException(
        transactionListResponse.error.message,
      );
    } else {
      throw RemoteRepositoryException(
        'Unexpected TransactionListResponse: ${transactionListResponse.toString()}',
      );
    }
  }

  Headers _getHeadersWithAuth(String sessionId) {
    var headers = <String, String>{
      'x-auth-token': sessionId,
    };
    headers.addAll(_headers);
    return headers;
  }
}
