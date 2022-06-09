import 'package:http/http.dart' as http;
import 'package:mp3_client_core/mp3_client_core.dart';

import 'http_client.dart';

enum _HttpMethod { get, post }

class SimpleHttpClient implements HttpClient {
  static const List<int> _defaultAcceptedResponseCodes = [200];
  final int readTimeout;

  const SimpleHttpClient([this.readTimeout = 60]);

  @override
  Future<String> get(
    String uriString, {
    Map<String, String>? additionalHeaders,
    List<int>? acceptedResponseCodes,
  }) async {
    return await _fetchData(
      _HttpMethod.get,
      uriString,
      acceptedResponseCodes ?? _defaultAcceptedResponseCodes,
      additionalHeaders,
    );
  }

  @override
  Future<String> post(
    String uriString, {
    String? requestBody,
    Map<String, String>? additionalHeaders,
    List<int>? acceptedResponseCodes,
  }) async {
    return await _fetchData(
      _HttpMethod.post,
      uriString,
      acceptedResponseCodes ?? _defaultAcceptedResponseCodes,
      additionalHeaders,
      requestBody,
    );
  }

  Future<String> _fetchData(
    _HttpMethod httpMethod,
    String uriString,
    List<int> acceptedResponseCodes, [
    Map<String, String>? additionalHeaders,
    String? requestBody,
  ]) async {
    var uri = Uri.parse(uriString);
    //TODO: generate user-agent
    var headers = <String, String>{'User-Agent': 'MP3MobileClient/0.0.1'};
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }
    http.Response response;
    switch (httpMethod) {
      case _HttpMethod.post:
        response = await http
            .post(uri, headers: headers, body: requestBody)
            .timeout(Duration(seconds: readTimeout));
        break;
      case _HttpMethod.get:
        response = await http
            .get(uri, headers: headers)
            .timeout(Duration(seconds: readTimeout));
        break;
    }
    if (acceptedResponseCodes.contains(response.statusCode)) {
      return response.body;
    } else {
      throw RemoteRepositoryException(
        'Remote service response contain bad response code. '
        'Request uri: $uri. '
        'Request headers: $headers. '
        'Request body: $requestBody. '
        'Response code is ${response.statusCode}. '
        'Response body: ${response.body}',
      );
    }
  }
}
