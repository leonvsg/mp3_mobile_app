import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mportal3_core/mportal3_core.dart';

import 'loyalty_history_item.dart';
import 'order_history_item.dart';
import 'payer.dart';
import 'shopping_cart.dart';

import 'attribute.dart';

part 'order.freezed.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required String mdOrder,
    required String orderNumber,
    required OrderState state,
    String? actionCode,
    required Currency currency,
    required String merchantLogin,
    required String createdDate,
    required PaymentSystem paymentSystem,
    required FraudStatus fraudStatus,
    required num registeredAmount,
    int? depositedAmount,
    int? refundedAmount,
    required int feeAmount,
    // the value of this column depends on the order state
    // CREATED, REVERSED, DECLINED: the registered amount
    // APPROVED: approved amount
    // DEPOSITED, REFUNDED: deposited amount
    required int amount,
    String? ip,
    DateTime? authDate,
    required PaymentType paymentType,
    required PaymentTypeExtension paymentTypeExtension,
    OfdStatus? ofdStatus,
    String? maskedPan,
    String? issuerBankName,
    String? issuerCountryName,
    String? cardholder,
    String? cardExpiry,
    //TODO: replace with enum. possible values: 01, 02, 05, 06, 07, 09, 10
    String? eci,
    required List<Attribute> orderAttributes,
    required List<OrderHistoryItem> history,
    Payer? payer,
    required bool withLoyalty,
    List<LoyaltyHistoryItem>? loyaltyHistory,
    required bool creditOperation,
    String? expirationDate,
    DateTime? lastRefundedDate,
    DateTime? completionDate,
    String? description,
    String? paymentPageUrl,
    PaymentMethod? paymentMethod,
    String? externalScaExemptionIndicator,
    String? avsCode,
    int? avsValue,
    String? avsDescription,
    ShoppingCart? shoppingCart,
  }) = _Order;
}
