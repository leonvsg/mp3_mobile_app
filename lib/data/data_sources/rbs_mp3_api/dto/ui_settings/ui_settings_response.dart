import 'package:freezed_annotation/freezed_annotation.dart';

import '../attribute.dart';
import '../error/error_response.dart';

part 'ui_settings_response.freezed.dart';
part 'ui_settings_response.g.dart';

@Freezed(unionKey: 'status')
class UiSettingsResponse with _$UiSettingsResponse {
  const UiSettingsResponse._();

  @FreezedUnionValue('SUCCESS')
  const factory UiSettingsResponse.success({
    required List<Attribute> uiSettings,
    required String status,
  }) = UiSettingsResponseSuccess;

  @FreezedUnionValue('FAIL')
  const factory UiSettingsResponse.error({
    required String status,
    required ErrorResponse error,
  }) = UiSettingsResponseError;

  factory UiSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$UiSettingsResponseFromJson(json);
}
