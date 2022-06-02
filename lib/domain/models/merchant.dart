import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'currency.dart';
import 'enums.dart';

part 'merchant.freezed.dart';

@freezed
class Merchant with _$Merchant {
  const factory Merchant({
    required final String login,
    required final String fullName,
    final String? openIdToken,
    required final Currency defaultCurrency,
    required final List<Currency> currencies,
    required final List<MerchantOption> options,
    required final int sessionTimeoutMinutes,
    required final List<Locale> locales,
    final String? email,
    final String? mainUrl,
    final List<int>? merchantTerms,
    final String? knp,
  }) = _Merchant;
}
