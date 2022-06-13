import 'package:freezed_annotation/freezed_annotation.dart';

import 'shopping_cart_item.dart';

part 'shopping_cart.freezed.dart';

@freezed
class ShoppingCart with _$ShoppingCart {
  const factory ShoppingCart({
    List<ShoppingCartItem>? items,
    required bool complete,
    required bool ignored,
  }) = _ShoppingCart;
}
