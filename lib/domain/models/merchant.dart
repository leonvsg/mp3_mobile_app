import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'currency.dart';
import 'enums.dart';

class Merchant extends Equatable {
  final String login;
  final String fullName;
  final String? openIdToken;
  final Currency defaultCurrency;
  final List<Currency> currencies;
  final List<Permission> permissions;
  final int sessionTimeoutMinutes;
  final List<Locale> locales;
  final String? email;
  final String? mainUrl;
  final List<int>? merchantTerms;
  final String? knp;

  const Merchant({
    required this.login,
    required this.fullName,
    this.openIdToken,
    required this.defaultCurrency,
    required this.currencies,
    required this.permissions,
    required this.sessionTimeoutMinutes,
    required this.locales,
    this.email,
    required this.mainUrl,
    this.merchantTerms,
    this.knp,
  });

  @override
  List<Object?> get props => [
        login,
        fullName,
        openIdToken,
        defaultCurrency,
        currencies,
        permissions,
        sessionTimeoutMinutes,
        locales,
        email,
        mainUrl,
        merchantTerms,
        knp,
      ];

  @override
  bool get stringify => true;
}
