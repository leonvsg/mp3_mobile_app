import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:mp3_mobile_app/domain/models.dart';

import '../merchants_dao.dart';
import 'database.dart';
import 'tables.dart';

part 'drift_merchants_dao.g.dart';

@DriftAccessor(tables: [
  Merchants,
  Currencies,
  MerchantCurrencies,
  MerchantPermissions,
  MerchantLocales,
  MerchantTerms,
])
class DriftMerchantsDao extends DatabaseAccessor<AppDb>
    with _$DriftMerchantsDaoMixin
    implements MerchantsDao {
  DriftMerchantsDao(AppDb db) : super(db);

  @override
  Future<void> deleteAllMerchants() {
    return transaction(() async {
      await delete(merchantCurrencies).go();
      await delete(merchantPermissions).go();
      await delete(merchantLocales).go();
      await delete(merchantTerms).go();
      await delete(merchants).go();
    });
  }

  @override
  Future<void> deleteMerchant(String login) {
    return transaction(() async {
      await (delete(merchantCurrencies)
            ..where((tbl) => tbl.merchant.equals(login)))
          .go();
      await (delete(merchantPermissions)
            ..where((tbl) => tbl.merchant.equals(login)))
          .go();
      await (delete(merchantLocales)
            ..where((tbl) => tbl.merchant.equals(login)))
          .go();
      await (delete(merchantTerms)..where((tbl) => tbl.merchant.equals(login)))
          .go();
      await (delete(merchants)..where((tbl) => tbl.login.equals(login))).go();
    });
  }

  @override
  Future<Merchant> getMerchant(String login) async {
    final merchantStatement = select(merchants).join([
      innerJoin(
        currencies,
        currencies.alphabeticCode.equalsExp(merchants.defaultCurrency),
      ),
    ])
      ..where(merchants.login.equals(login));
    final currenciesStatement = select(merchantCurrencies).join([
      innerJoin(
        currencies,
        currencies.alphabeticCode.equalsExp(merchantCurrencies.currency),
      ),
    ])
      ..where(merchantCurrencies.merchant.equals(login));
    final permissionsStatement = select(merchantPermissions)
      ..where((tbl) => tbl.merchant.equals(login));
    final localesStatement = select(merchantLocales)
      ..where((tbl) => tbl.merchant.equals(login));
    final termsStatement = select(merchantTerms)
      ..where((tbl) => tbl.merchant.equals(login));
    final result = await merchantStatement.getSingle();
    return _toModel(
      merchantDto: result.readTable(merchants),
      currencyDto: result.readTable(currencies),
      merchantCurrencyDto: (await currenciesStatement.get())
          .map((result) => result.readTable(currencies))
          .toList(),
      merchantLocaleDto: await localesStatement.get(),
      merchantPermissionDto: await permissionsStatement.get(),
      merchantTermDto: await termsStatement.get(),
    );
  }

  @override
  Future<void> saveOrUpdateMerchant(Merchant merchant) {
    return transaction(() async {
      await into(merchants).insertOnConflictUpdate(_toDto(merchant));
      await (delete(merchantCurrencies)
            ..where((tbl) => tbl.merchant.equals(merchant.login)))
          .go();
      await batch(
        (batch) => batch.insertAll(
          merchantCurrencies,
          merchant.currencies
              .map(
                (currency) => MerchantCurrencyDto(
                  merchant: merchant.login,
                  currency: currency.alphabeticCode,
                ),
              )
              .toList(),
        ),
      );
      await (delete(merchantPermissions)
            ..where((tbl) => tbl.merchant.equals(merchant.login)))
          .go();
      await batch(
        (batch) => batch.insertAll(
          merchantPermissions,
          merchant.options
              .map(
                (permission) => MerchantPermissionDto(
                  merchant: merchant.login,
                  permission: permission.name,
                ),
              )
              .toList(),
        ),
      );
      await (delete(merchantLocales)
            ..where((tbl) => tbl.merchant.equals(merchant.login)))
          .go();
      await batch(
        (batch) => batch.insertAll(
          merchantLocales,
          merchant.locales
              .map(
                (locale) => MerchantLocaleDto(
                  locale: locale.languageCode,
                  merchant: merchant.login,
                ),
              )
              .toList(),
        ),
      );
      await (delete(merchantTerms)
            ..where((tbl) => tbl.merchant.equals(merchant.login)))
          .go();
      final list = merchant.merchantTerms
          ?.map(
            (term) => MerchantTermsDto(
              merchant: merchant.login,
              term: term,
            ),
          )
          .toList();
      if (list != null) {
        await batch(
          (batch) => batch.insertAll(
            merchantTerms,
            list,
          ),
        );
      }
    });
  }

  Merchant _toModel({
    required MerchantDto merchantDto,
    required CurrencyDto currencyDto,
    required List<CurrencyDto> merchantCurrencyDto,
    required List<MerchantPermissionDto> merchantPermissionDto,
    required List<MerchantLocaleDto> merchantLocaleDto,
    required List<MerchantTermsDto> merchantTermDto,
  }) {
    return Merchant(
      login: merchantDto.login,
      fullName: merchantDto.fullName,
      defaultCurrency: _currencyDtoToModel(currencyDto),
      currencies: merchantCurrencyDto
          .map(
            (dto) => _currencyDtoToModel(dto),
          )
          .toList(),
      options: merchantPermissionDto
          .map((dto) => _stringToPermission(dto.permission))
          .toList(),
      sessionTimeoutMinutes: merchantDto.sessionTimeoutMinutes,
      locales: merchantLocaleDto.map((dto) => Locale(dto.locale)).toList(),
      mainUrl: merchantDto.mainUrl,
      openIdToken: merchantDto.openIdToken,
      knp: merchantDto.knp,
      email: merchantDto.email,
      merchantTerms: merchantTermDto.map((dto) => dto.term).toList(),
    );
  }

  Currency _currencyDtoToModel(CurrencyDto dto) {
    return Currency(
      alphabeticCode: dto.alphabeticCode,
      minorUnit: dto.minorUnit,
      numericCode: dto.numericCode,
      name: dto.name,
    );
  }

  MerchantOption _stringToPermission(String str) {
    var permission = MerchantOption.unknown;
    try {
      permission = MerchantOption.values.byName(str);
    } on ArgumentError {
      //TODO: logging
    }
    return permission;
  }

  MerchantDto _toDto(Merchant model) {
    return MerchantDto(
      login: model.login,
      fullName: model.fullName,
      defaultCurrency: model.defaultCurrency.alphabeticCode,
      sessionTimeoutMinutes: model.sessionTimeoutMinutes,
      email: model.email,
      knp: model.knp,
      openIdToken: model.openIdToken,
      mainUrl: model.mainUrl,
    );
  }
}
