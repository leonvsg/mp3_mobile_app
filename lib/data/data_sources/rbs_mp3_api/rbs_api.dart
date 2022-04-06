import 'dto.dart';

abstract class RbsApi {
  Future<AuthResponse> auth(AuthRequest requestBody);

  Future<MerchantInformationResponse> fetchMerchantInformation(
    MerchantInformationRequest requestBody,
    String sessionId,
  );

  Future<UiSettingsResponse> fetchUiSettings(String sessionId);

  Future<TransactionListResponse> fetchTransactionList(
    TransactionListRequest requestBody,
    String sessionId,
  );

  Future<TransactionDetailsResponse> fetchTransactionDetails(
    TransactionDetailsRequest requestBody,
    String sessionId,
  );
}
