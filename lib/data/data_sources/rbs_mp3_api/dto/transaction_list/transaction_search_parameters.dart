import 'package:freezed_annotation/freezed_annotation.dart';

import 'range.dart';

part 'transaction_search_parameters.freezed.dart';
part 'transaction_search_parameters.g.dart';

@freezed
class TransactionSearchParameters with _$TransactionSearchParameters {
  const factory TransactionSearchParameters({
    Range? amountRange,
    List<String>? merchantLogins,
    List<String>? ofdStatuses,
    String? paymentType,
    required Range period,
    String? orderNumber,
    List<String>? states,
    String? mdOrder,
    String? actionCode,
    String? panLastFourDigits,
    String? payerEmail,
    List<String>? paymentSystems,
  }) = _TransactionSearchParameters;

  factory TransactionSearchParameters.fromJson(Map<String, dynamic> json) =>
      _$TransactionSearchParametersFromJson(json);
}