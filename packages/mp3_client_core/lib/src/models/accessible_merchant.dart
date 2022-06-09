import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'accessible_merchant.freezed.dart';

@freezed
class AccessibleMerchant with _$AccessibleMerchant {
  const factory AccessibleMerchant({
    required final String merchantLogin,
    required final String merchantFullName,
    required final MerchantType merchantType,
  }) = _AccessibleMerchant;
}
