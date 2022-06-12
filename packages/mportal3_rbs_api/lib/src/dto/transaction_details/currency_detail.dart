import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_detail.freezed.dart';
part 'currency_detail.g.dart';

@freezed
class CurrencyDetail with _$CurrencyDetail {
  const factory CurrencyDetail({
    required String alphabeticCode,
    required int minorUnit,
  }) = _CurrencyDetail;

  factory CurrencyDetail.fromJson(Map<String, dynamic> map) =>
      _$CurrencyDetailFromJson(map);
}
