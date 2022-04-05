import 'package:equatable/equatable.dart';

import 'order_params.dart';

class SimpleOrderData extends Equatable {
  final int? actionCode;
  final double amount;
  final DateTime createdDate;
  final String currency;
  final double feeAmount;
  final String mdOrder;
  final String merchantLogin;
  final OfdStatus? ofdStatus;
  final String orderNumber;
  final DateTime? paymentDate;
  final PaymentSystem paymentSystem;
  final PaymentType paymentType;
  final PaymentTypeExtension paymentTypeExtension;
  final double refundedAmount;
  final OrderState orderState;
  final String? shortDescription;
  final bool? withLoyalty;

  const SimpleOrderData({
    this.actionCode,
    required this.amount,
    required this.createdDate,
    required this.currency,
    required this.feeAmount,
    required this.mdOrder,
    required this.merchantLogin,
    this.ofdStatus,
    required this.orderNumber,
    this.paymentDate,
    required this.paymentSystem,
    required this.paymentType,
    required this.paymentTypeExtension,
    required this.refundedAmount,
    required this.orderState,
    this.shortDescription,
    this.withLoyalty,
  });

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props =>
      [
        actionCode,
        amount,
        createdDate,
        currency,
        feeAmount,
        mdOrder,
        merchantLogin,
        ofdStatus,
        orderNumber,
        paymentDate,
        paymentSystem,
        paymentType,
        paymentTypeExtension,
        refundedAmount,
        orderState,
        shortDescription,
        withLoyalty,
      ];
}