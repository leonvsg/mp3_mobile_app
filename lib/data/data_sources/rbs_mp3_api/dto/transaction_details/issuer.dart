import 'package:freezed_annotation/freezed_annotation.dart';

part 'issuer.freezed.dart';
part 'issuer.g.dart';

@freezed
class Issuer with _$Issuer {
  const factory Issuer({
    String? issuerBankName,
    String? issuerCountryName,
  }) = _Issuer;

  factory Issuer.fromJson(Map<String, dynamic> json) => _$IssuerFromJson(json);
}
