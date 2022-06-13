import 'package:freezed_annotation/freezed_annotation.dart';

part 'payer.freezed.dart';

@freezed
class Payer with _$Payer {
  const factory Payer({
    String? phone,
    String? name,
    String? address,
    String? city,
    String? country,
    String? postalCode,
    String? state,
    String? email,
  }) = _Payer;
}
