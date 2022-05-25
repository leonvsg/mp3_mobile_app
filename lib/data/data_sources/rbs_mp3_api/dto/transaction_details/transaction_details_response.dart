import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/error_response.dart';

import 'transaction.dart';

part 'transaction_details_response.freezed.dart';
part 'transaction_details_response.g.dart';

@Freezed(unionKey: 'status')
class TransactionDetailsResponse with _$TransactionDetailsResponse {
  const TransactionDetailsResponse._();

  @FreezedUnionValue('SUCCESS')
  const factory TransactionDetailsResponse.success({
    required String status,
    required Transaction transaction,
  }) = TransactionDetailsResponseSuccess;

  @FreezedUnionValue('FAIL')
  const factory TransactionDetailsResponse.error({
    required String status,
    required ErrorResponse error,
  }) = TransactionDetailsResponseFail;

  factory TransactionDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsResponseFromJson(json);
}