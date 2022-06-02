import 'package:freezed_annotation/freezed_annotation.dart';

import 'amount_range.dart';
import 'date_period.dart';
import 'enums.dart';

part 'orders_search_filter.freezed.dart';

@freezed
class OrdersSearchFilter with _$OrdersSearchFilter {
  const factory OrdersSearchFilter({
    final AmountRange? amountRange,
    final List<String>? merchantLogins,
    final List<OfdStatus>? ofdStatuses,
    final PaymentType? paymentType,
    required final DatePeriod period,
    final String? orderNumber,
    final List<OrderState>? states,
    final String? mdOrder,
    final int? actionCode,
    final List<PaymentSystem>? paymentSystems,
    final String? payerEmail,
  }) = _OrdersSearchFilter;
}
