import 'package:freezed_annotation/freezed_annotation.dart';

part 'loyalty.freezed.dart';
part 'loyalty.g.dart';

@freezed
class Loyalty with _$Loyalty {
  const factory Loyalty({
    //SBRF_SPASIBO, SBRF_SBERMILES
    String? loyaltyServiceName,
    int? loyaltyAward,
    int? loyaltyPayment,
  }) = _Loyalty;

  factory Loyalty.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyFromJson(json);
}
