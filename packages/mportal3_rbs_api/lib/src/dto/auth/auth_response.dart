import 'package:freezed_annotation/freezed_annotation.dart';

import 'accessible_merchant.dart';
import '../error/error_response.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@Freezed(unionKey: 'status')
class AuthResponse with _$AuthResponse {
  const AuthResponse._();

  @FreezedUnionValue('SUCCESS')
  const factory AuthResponse.success({
    required String sessionId,
    @JsonKey(name: 'login') required String userLogin,
    required String merchantLogin,
    String? email,
    required List<String> permissions,
    required List<AccessibleMerchant> accessibleMerchants,
    required String status,
  }) = AuthResponseSuccess;

  @FreezedUnionValue('FAIL')
  const factory AuthResponse.error({
    required String status,
    required ErrorResponse error,
  }) = AuthResponseError;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
