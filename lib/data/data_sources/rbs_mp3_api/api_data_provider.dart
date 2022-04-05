import 'dart:convert';
import 'package:mp3_mobile_app/common/http/http_client.dart';

import 'dto.dart';

typedef Headers = Map<String,String>;

class RbsApiDataProvider {

  //TODO: update http req/res logging

  static const _baseUrl = 'https://web.rbsuat.com';
  static const _applicationContextUrl = '$_baseUrl/ab/mp3';
  static const _acceptedResponseCodes = [200, 400];

  static const Headers _headers = {
    'Content-Type': 'application/json',
    'Referer': _baseUrl,
  };

  final HttpClient httpClient;

  const RbsApiDataProvider(this.httpClient);

  Future<AuthResponse> auth(AuthRequest requestBody) async {
    //log('Try to authenticate by login ${requestBody.login}');
    var response = await httpClient.post(
      '$_applicationContextUrl/auth/login',
      requestBody: jsonEncode(requestBody.toJson()),
      additionalHeaders: _headers,
      acceptedResponseCodes: _acceptedResponseCodes,
    );
    //log('Authentication result: $response');

    return AuthResponse.fromJson(jsonDecode(response));
  }

  Future<MerchantInformationResponse> fetchMerchantInformation(
      MerchantInformationRequest requestBody,
      String sessionId,
      ) async {
    //log('Get merchant information: $requestBody');
    var headers = _getHeadersWithAuth(sessionId);
    var response = await httpClient.post(
      '$_applicationContextUrl/merchant/information',
      requestBody: jsonEncode(requestBody.toJson()),
      additionalHeaders: headers,
    );
    //log('Merchant information response: $response');

    return MerchantInformationResponse.fromJson(json.decode(response));
  }

  Future<UiSettingsResponse> fetchUiSettings(String sessionId) async {
    //log('Get UI settings');
    var headers = _getHeadersWithAuth(sessionId);
    var response = await httpClient.post(
      '$_applicationContextUrl/ui/settings',
      additionalHeaders: headers,
    );
    //log('UI settings: $response');

    return UiSettingsResponse.fromJson(json.decode(response));
  }

  Future<TransactionListResponse> fetchTransactionList(
      TransactionListRequest requestBody,
      String sessionId,
      ) async {
    //log('Get transaction list: $requestBody');
    var headers = _getHeadersWithAuth(sessionId);
    var response = await httpClient.post(
      '$_applicationContextUrl/transaction/list',
      requestBody: jsonEncode(requestBody.toJson()),
      additionalHeaders: headers,
    );
    //log('Transaction list response: $response');

    return TransactionListResponse.fromJson(json.decode(response));
  }

  Future<TransactionDetailsResponse> fetchTransactionDetails(
      TransactionDetailsRequest requestBody,
      String sessionId,
      ) async {
    //log('Get transaction details: $requestBody');
    var headers = _getHeadersWithAuth(sessionId);
    var response = await httpClient.post(
      '$_applicationContextUrl/transaction/details',
      requestBody: jsonEncode(requestBody.toJson()),
      additionalHeaders: headers,
    );
    //log('Transaction details response: $response');

    return TransactionDetailsResponse.fromJson(json.decode(response));
  }

  Headers _getHeadersWithAuth(String sessionId) {
    var headers = <String, String>{
      'x-auth-token': sessionId,
    };
    headers.addAll(_headers);

    return headers;
  }
}
