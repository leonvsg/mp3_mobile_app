import 'package:mp3_client_core/mp3_client_core.dart';

abstract class OrderRepository {
  Future<List<SimpleOrderData>> getOrdersList({
    required OrdersSearchFilter filter,
    int pageSize,
    int startIndex,
  });
  Future<Order?> getOrder(String mdOrder);
}