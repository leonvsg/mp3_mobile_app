import '../../models.dart';

abstract class Mp3Api {
  Future<Session> auth(String login, String password);

  Future<Merchant> fetchMerchantInformation(
    String merchantLogin,
    String sessionId,
  );

  Future<List<SimpleOrderData>> fetchTransactionList(
    OrdersSearchFilter requestBody,
    String sessionId,
  );

  Future<Order> fetchTransactionDetails(
    String mdOrder,
    String sessionId,
  );
}
