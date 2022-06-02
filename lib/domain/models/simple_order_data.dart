import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'simple_order_data.freezed.dart';

@freezed
class SimpleOrderData with _$SimpleOrderData {
  const factory SimpleOrderData({
    final int? actionCode,
    required final double amount,
    required final DateTime createdDate,
    required final String currency,
    required final double feeAmount,
    required final String mdOrder,
    required final String merchantLogin,
    final OfdStatus? ofdStatus,
    required final String orderNumber,
    final DateTime? paymentDate,
    required final PaymentSystem paymentSystem,
    required final PaymentType paymentType,
    required final PaymentTypeExtension paymentTypeExtension,
    required final double refundedAmount,
    required final OrderState orderState,
    final String? shortDescription,
    final bool? withLoyalty,
  }) = _SimpleOrderData;
}
