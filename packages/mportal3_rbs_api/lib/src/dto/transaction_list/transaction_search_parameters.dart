import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mportal3_core/mportal3_core.dart';

import '../mapper.dart';
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
  
  factory TransactionSearchParameters.fromEntity(OrdersSearchFilter filter) {
    final period = Range(
      from: formatDateWithOffset(filter.period.from.toLocal()),
      to: formatDateWithOffset(filter.period.to.toLocal()),
    );
    Range? amountRange;
    final filterAmountRange = filter.amountRange;
    if (filterAmountRange != null) {
      amountRange = Range(
        to: filterAmountRange.maxAmount.toString(),
        from: filterAmountRange.minAmount.toString(),
      );
    }
    String? paymentType;
    if (filter.paymentType != null &&
        paymentTypeMap.containsValue(filter.paymentType)) {
      paymentType = paymentTypeMap.entries
          .firstWhere((element) => element.value == filter.paymentType)
          .key;
    }

    return TransactionSearchParameters(
      period: period,
      actionCode: filter.actionCode?.toString(),
      amountRange: amountRange,
      mdOrder: filter.mdOrder,
      merchantLogins: filter.merchantLogins,
      ofdStatuses: filter.ofdStatuses?.map((status) => status.name).toList(),
      orderNumber: filter.orderNumber,
      paymentType: paymentType,
      paymentSystems: filter.paymentSystems
          ?.map((paymentSystem) => paymentSystem.name)
          .toList(),
      states: filter.states?.map((state) => state.name).toList(),
      payerEmail: filter.payerEmail,
    );
  }
}