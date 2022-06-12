import 'package:freezed_annotation/freezed_annotation.dart';

import 'page.dart';
import 'transaction_search_parameters.dart';

part 'transaction_list_request.freezed.dart';
part 'transaction_list_request.g.dart';

@freezed
class TransactionListRequest with _$TransactionListRequest {
  const factory TransactionListRequest({
    required TransactionSearchParameters search,
    required TransactionSearchPage nextPage,
    String? merchantLogin,
    //"PAYMENT_TYPE, PAYMENT_SYSTEM, CREATED_DATE, UPDATED_DATE, AMOUNT, CURRENCY, MERCHANT_LOGIN, ORDER_NUMBER, STATE, PAN, PAYMENT_DATE, COMPLETION_DATE, REFUNDED_DATE, ACTION_CODE, EMAIL, PROCESSING_ID, TERMINAL_ID, REFERENCE_NUMBER, CARDHOLDER, MD_ORDER, FEE_AMOUNT, REFUNDED_AMOUNT, ORDER_PARAMS, OFD_STATUS, SHORT_DESCRIPTION, CREDIT_RIGHT_TERMS, CREDIT_TERM, CREDIT_PRODUCT_ID, CREDIT_PRODUCT_TYPE, CREDIT_INITIAL_AMOUNT, CREDIT_DOCUMENT_UID, CREDIT_BANK_CODE_TYPE, CREDIT_BANK_NAME"
    List<String>? columns,
}) = _TransactionListRequest;

  factory TransactionListRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionListRequestFromJson(json);
}