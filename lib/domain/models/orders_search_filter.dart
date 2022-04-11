import 'package:equatable/equatable.dart';

import 'date_period.dart';
import 'amount_range.dart';
import 'enums.dart';

class OrdersSearchFilter extends Equatable {
  final AmountRange? amountRange;
  final List<String>? merchantLogins;
  final List<OfdStatus>? ofdStatuses;
  final PaymentType? paymentType;
  final DatePeriod period;
  final String? orderNumber;
  final List<OrderState>? states;
  final String? mdOrder;
  final int? actionCode;
  final List<PaymentSystem>? paymentSystems;
  final String? payerEmail;

  const OrdersSearchFilter({
    this.amountRange,
    this.merchantLogins,
    this.ofdStatuses,
    this.paymentType,
    required this.period,
    this.orderNumber,
    this.states,
    this.mdOrder,
    this.actionCode,
    this.paymentSystems,
    this.payerEmail,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [
        amountRange,
        merchantLogins,
        ofdStatuses,
        paymentType,
        period,
        orderNumber,
        states,
        mdOrder,
        actionCode,
        paymentSystems,
        payerEmail,
      ];
}






