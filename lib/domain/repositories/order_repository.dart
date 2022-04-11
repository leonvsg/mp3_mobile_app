import 'package:mp3_mobile_app/domain/models/order.dart';
import 'package:mp3_mobile_app/domain/models/orders_search_filter.dart';
import 'package:mp3_mobile_app/domain/models/simple_order_data.dart';

abstract class OrderRepository {
  Future<List<SimpleOrderData>> getOrdersList({
    required OrdersSearchFilter filter,
    int pageSize,
    int startIndex,
  });
  Future<Order?> getOrder(String mdOrder);
}