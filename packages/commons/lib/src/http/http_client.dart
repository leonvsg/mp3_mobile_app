abstract class HttpClient {
  Future<String> get(
      String uriString, {
        Map<String, String>? additionalHeaders,
        List<int>? acceptedResponseCodes,
      });

  Future<String> post(
      String uriString, {
        String? requestBody,
        Map<String, String>? additionalHeaders,
        List<int>? acceptedResponseCodes,
      });
}