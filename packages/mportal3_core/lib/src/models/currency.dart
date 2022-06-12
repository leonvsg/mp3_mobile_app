import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';

@freezed
class Currency with _$Currency {
  const factory Currency({
    required final String alphabeticCode,
    required final int minorUnit,
    final String? numericCode,
    final String? name,
  }) = _Currency;
}
