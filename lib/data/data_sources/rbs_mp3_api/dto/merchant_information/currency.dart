import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';
part 'currency.g.dart';

@freezed
class Currency with _$Currency {
  const factory Currency({
    required String currencyName,
    required int minorUnit,
    @JsonKey(name: 'default') required bool isDefault,
  }) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> map) =>
      _$CurrencyFromJson(map);
}
