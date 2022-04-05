import 'package:http/http.dart' as http;
import 'package:mp3_mobile_app/domain/exceptions.dart';

enum HttpMethod { get, post }

class HttpClient {
  static const List<int> _defaultAcceptedResponseCodes = [200];
  final int readTimeout;

  HttpClient(this.readTimeout);

  Future<String> get(
    String uriString, {
    Map<String, String>? additionalHeaders,
    List<int>? acceptedResponseCodes,
  }) async {
    return await _fetchData(
        HttpMethod.get,
        uriString,
        acceptedResponseCodes ?? _defaultAcceptedResponseCodes,
        additionalHeaders);
  }

  Future<String> post(
    String uriString, {
    String? requestBody,
    Map<String, String>? additionalHeaders,
    List<int>? acceptedResponseCodes,
  }) async {
    return await _fetchData(
        HttpMethod.post,
        uriString,
        acceptedResponseCodes ?? _defaultAcceptedResponseCodes,
        additionalHeaders,
        requestBody);
  }

  Future<String> _fetchData(
    HttpMethod httpMethod,
    String uriString,
    List<int> acceptedResponseCodes, [
    Map<String, String>? additionalHeaders,
    String? requestBody,
  ]) async {
    var uri = Uri.parse(uriString);
    var headers = <String, String>{'User-Agent': 'MP3MobileClient/0.0.1'};
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }
    http.Response response;
    switch (httpMethod) {
      case HttpMethod.post:
        response = await http.post(uri, headers: headers, body: requestBody);
        break;
      case HttpMethod.get:
        response = await http.get(uri, headers: headers);
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
          'Response body: ${response.body}');
    }
  }
}
