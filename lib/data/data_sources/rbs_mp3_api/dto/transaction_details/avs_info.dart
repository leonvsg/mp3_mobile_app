import 'package:freezed_annotation/freezed_annotation.dart';

part 'avs_info.freezed.dart';
part 'avs_info.g.dart';

@freezed
class AvsInfo with _$AvsInfo {
  const factory AvsInfo({
    String? avsCode,
    int? avsValue,
    String? avsDescription,
  }) = _AvsInfo;

  factory AvsInfo.fromJson(Map<String, dynamic> json) =>
      _$AvsInfoFromJson(json);
}
