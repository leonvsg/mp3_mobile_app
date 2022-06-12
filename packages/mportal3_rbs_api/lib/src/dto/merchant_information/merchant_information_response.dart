import 'package:freezed_annotation/freezed_annotation.dart';

import 'currency.dart';
import '../error/error_response.dart';

part 'merchant_information_response.freezed.dart';
part 'merchant_information_response.g.dart';

@Freezed(unionKey: 'status')
class MerchantInformationResponse with _$MerchantInformationResponse {
  const MerchantInformationResponse._();

  @FreezedUnionValue('SUCCESS')
  const factory MerchantInformationResponse.success({
    required String status,
    String? openIdToken,
    required List<Currency> currencies,
    required List<String> options,
    required int sessionTimeoutMinutes,
    required List<String> locales,
    @JsonKey(name: 'emails') String? email,
    required String mainUrl,
    required String fullName,
    List<int>? merchantTerms,
    String? knp,
  }) = MerchantInformationResponseSuccess;

  @FreezedUnionValue('FAIL')
  const factory MerchantInformationResponse.error({
    required String status,
    required ErrorResponse error,
  }) = MerchantInformationResponseFail;

  factory MerchantInformationResponse.fromJson(Map<String, dynamic> map) =>
      _$MerchantInformationResponseFromJson(map);
}
