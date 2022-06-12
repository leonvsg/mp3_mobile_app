import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_list_item.freezed.dart';
part 'transaction_list_item.g.dart';

@freezed
class TransactionListItem with _$TransactionListItem {
  const factory TransactionListItem({
    String? actionCode,
    required String amount,
    required String createdDate,
    required String currency,
    required String feeAmount,
    required String mdOrder,
    required String merchantLogin,
    String? ofdStatus,
    required String orderNumber,
    String? paymentDate,
    required String paymentSystem,
    required String paymentType,
    required String paymentTypeExtension,
    required String refundedAmount,
    required String state,
    String? shortDescription,
    bool? withLoyalty,
}) = _TransactionListItem;

  factory TransactionListItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionListItemFromJson(json);
}