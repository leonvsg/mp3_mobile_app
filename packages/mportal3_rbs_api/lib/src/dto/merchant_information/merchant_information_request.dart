import 'package:freezed_annotation/freezed_annotation.dart';

part 'merchant_information_request.g.dart';
part 'merchant_information_request.freezed.dart';

@freezed
class MerchantInformationRequest with _$MerchantInformationRequest {
  const factory MerchantInformationRequest({
    required String merchantLogin,
  }) = _MerchantInformationRequest;

  factory MerchantInformationRequest.fromJson(Map<String, dynamic> json) =>
      _$MerchantInformationRequestFromJson(json);
}
