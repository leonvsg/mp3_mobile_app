import 'package:freezed_annotation/freezed_annotation.dart';

import '../attribute.dart';
import 'avs_info.dart';
import 'currency_detail.dart';
import 'history.dart';
import 'issuer.dart';
import 'loyalty.dart';
import 'payer_data.dart';
import 'shopping_cart.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String mdOrder,
    required String orderNumber,
    required String state,
    String? actionCode,
    required String currency,
    required CurrencyDetail currencyDetail,
    required String merchantLogin,
    required String createdDate,
    required String paymentSystem,
    required String fraudStatus, //NO_FRAUD, FRAUD_DETECTED
    required String registeredAmount,
    String? depositedAmount,
    String? refundedAmount,
    required String feeAmount,
    // the value of this column depends on the order state
    // CREATED, REVERSED, DECLINED: the registered amount
    // APPROVED: approved amount
    // DEPOSITED, REFUNDED: deposited amount
    required String amount,
    String? ip,
    String? authDate,
    required String paymentType,
    required String paymentTypeExtension,
    String? ofdStatus,
    String? maskedPan,
    @JsonKey(name: 'issuer_info') Issuer? issuer,
    String? cardholder,
    String? cardExpiry,
    String? eci, //01, 02, 05, 06, 07, 09, 10
    required List<Attribute> orderParams,
    required List<History> history,
    PayerData? payerData,
    required bool withLoyalty,
    List<Loyalty>? loyalties,
    required bool creditOperation,
    String? expirationDate,
    String? lastRefundedDate,
    String? completionDate,
    String? description,
    String? paymentPageUrl,
    String? paymentMethod,
    String? externalScaExemptionIndicator,
    AvsInfo? avsInfo,
    ShoppingCart? shoppingCart,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
