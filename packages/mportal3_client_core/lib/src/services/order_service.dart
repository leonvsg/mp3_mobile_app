import '../models.dart';

abstract class OrderService {
  Future<List<SimpleOrderData>> getOrdersList({
    required OrdersSearchFilter filter,
    int pageSize,
    int startIndex,
  });
  Future<Order?> getOrder(String mdOrder);
}