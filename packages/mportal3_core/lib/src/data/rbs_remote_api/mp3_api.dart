import '../../models.dart';

abstract class Mp3Api {
  Future<Session> auth({
    required String login,
    required String password,
  });

  Future<Merchant> fetchMerchantInformation({
    required String merchantLogin,
    required String sessionId,
  });

  Future<List<SimpleOrderData>> fetchTransactionList({
    required OrdersSearchFilter filter,
    required String sessionId,
    required int count,
    required int startIndex,
    String? merchantLogin,
  });

  Future<Order> fetchTransactionDetails({
    required String mdOrder,
    required String sessionId,
  });
}
