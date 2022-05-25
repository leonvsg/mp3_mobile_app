import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';
part 'error_response.g.dart';

@freezed
class ErrorResponse with _$ErrorResponse {

  const factory ErrorResponse({
    required String code,
    required String description,
    required String message,
    String? invalidFieldName,
  }) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> map) =>
      _$ErrorResponseFromJson(map);
}
