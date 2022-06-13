import 'package:freezed_annotation/freezed_annotation.dart';

import 'attribute.dart';

part 'shopping_cart_item.freezed.dart';

@freezed
class ShoppingCartItem with _$ShoppingCartItem {
  const factory ShoppingCartItem({
    required String code,
    required String name,
    required String position,
    int? positionInteger,
    double? quantity,
    String? measure,
    String? amount,
    String? price,
    String? taxType,
    String? taxSum,
    required bool loyaltyPaymentEnabled,
    String? paymentMethod,
    String? paymentObject,
    List<Attribute>? itemAttributes,
    double? refundedQuantity,
    String? refundedAmount,
    String? discountType,
    String? discountValue,
    String? itemDetails,
    required bool solid,
  }) = _ShoppingCartItem;
}
