import 'package:mp3_mobile_app/domain/entities/order.dart';
import 'package:mp3_mobile_app/domain/entities/orders_search_filter.dart';
import 'package:mp3_mobile_app/domain/entities/simple_order_data.dart';

abstract class OrderRepository {
  Future<List<SimpleOrderData>> getOrdersList({
    required OrdersSearchFilter filter,
    int pageSize,
    int startIndex,
  });
  Future<Order?> getOrder(String mdOrder);
}