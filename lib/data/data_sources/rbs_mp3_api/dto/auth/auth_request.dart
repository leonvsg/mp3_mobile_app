import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.g.dart';
part 'auth_request.freezed.dart';

@freezed
class AuthRequest with _$AuthRequest {
  const factory AuthRequest({
    required String password,
    required String login,
    @Default('ru') String language,
    String? code,
  }) = _AuthRequest;

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);
}
