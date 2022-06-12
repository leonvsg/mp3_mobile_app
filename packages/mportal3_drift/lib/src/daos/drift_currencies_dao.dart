import 'package:drift/drift.dart';
import 'package:mportal3_core/mportal3_core.dart';

import '../database.dart';
import '../tables.dart';

part 'drift_currencies_dao.g.dart';

@DriftAccessor(tables: [Currencies])
class DriftCurrenciesDao extends DatabaseAccessor<Mp3Database>
    with _$DriftCurrenciesDaoMixin
    implements CurrenciesDao {

  DriftCurrenciesDao(Mp3Database db) : super(db);

  @override
  Future<void> deleteAllCurrencies() => delete(currencies).go();

  @override
  Future<void> deleteCurrencyByAlphabeticCode(String alphabeticCode) =>
      (delete(currencies)
            ..where(
              (tbl) => tbl.alphabeticCode.equals(alphabeticCode),
            ))
          .go();

  @override
  Future<void> deleteCurrencyByNumericCode(String numericCode) =>
      (delete(currencies)
            ..where(
              (tbl) => tbl.numericCode.equals(numericCode),
            ))
          .go();

  @override
  Future<List<Currency>> getAllCurrencies() =>
      select(currencies).map((dto) => _toModel(dto)).get();

  @override
  Future<Currency?> getCurrencyByAlphabeticCode(String alphabeticCode) {
    final statement = select(currencies)
      ..where((tbl) => tbl.alphabeticCode.equals(alphabeticCode));
    return statement.map((dto) => _toModel(dto)).getSingleOrNull();
  }

  @override
  Future<Currency?> getCurrencyByNumericCode(String numericCode) {
    final statement = select(currencies)
      ..where((tbl) => tbl.numericCode.equals(numericCode));
    return statement.map((dto) => _toModel(dto)).getSingleOrNull();
  }

  @override
  Future<void> saveOrUpdateCurrency(Currency currency) =>
      into(currencies).insertOnConflictUpdate(_toDto(currency));

  @override
  Future<void> updateAllCurrencies(List<Currency> currenciesList) async {
    await delete(currencies).go();
    final list = currenciesList.map((model) => _toDto(model)).toList();
    return batch((batch) => batch.insertAll(currencies, list));
  }

  Currency _toModel(CurrencyDto dto) {
    return Currency(
      alphabeticCode: dto.alphabeticCode,
      minorUnit: dto.minorUnit,
      numericCode: dto.numericCode,
      name: dto.name,
    );
  }

  CurrencyDto _toDto(Currency model) {
    return CurrencyDto(
      alphabeticCode: model.alphabeticCode,
      minorUnit: model.minorUnit,
      numericCode: model.numericCode,
      name: model.name,
    );
  }
}
