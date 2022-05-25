import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/error_response.dart';
import 'transaction_list_item.dart';

part 'transaction_list_response.freezed.dart';
part 'transaction_list_response.g.dart';

@Freezed(unionKey: 'status')
class TransactionListResponse with _$TransactionListResponse {
  const TransactionListResponse._();

  @FreezedUnionValue('SUCCESS')
  const factory TransactionListResponse.success({
    required String status,
    required List<TransactionListItem> list,
}) = TransactionListResponseSuccess;

  @FreezedUnionValue('FAIL')
  const factory TransactionListResponse.error({
    required String status,
    required ErrorResponse error,
}) = TransactionListResponseFail;

  factory TransactionListResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionListResponseFromJson(json);
}