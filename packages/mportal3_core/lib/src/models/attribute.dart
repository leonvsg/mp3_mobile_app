import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute.freezed.dart';

@freezed
class Attribute with _$Attribute {
  const factory Attribute({
    required String name,
    required String value,
  }) = _Attribute;
}
