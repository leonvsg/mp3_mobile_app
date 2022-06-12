import 'package:freezed_annotation/freezed_annotation.dart';

part 'accessible_merchant.freezed.dart';
part 'accessible_merchant.g.dart';

@freezed
class AccessibleMerchant with _$AccessibleMerchant {
  const factory AccessibleMerchant({
    required String merchantLogin,
    required String merchantFullName,
    required String merchantType,
}) = _AccessibleMerchant;

  factory AccessibleMerchant.fromJson(Map<String, dynamic> json) =>
      _$AccessibleMerchantFromJson(json);
}