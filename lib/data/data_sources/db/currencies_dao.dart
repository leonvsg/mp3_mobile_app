import 'database.dart';

abstract class CurrenciesDao {

  Future<Currency> getCurrencyByAlphabeticCode(String alphabeticCode);
  Future<Currency> getCurrencyByNumericCode(int numericCode);
  Future<List<Currency>> getAllCurrencies();
  Future<void> saveOrUpdateCurrency(Currency currency);
  Future<void> deleteCurrencyByAlphabeticCode(String alphabeticCode);
  Future<void> deleteCurrencyByNumericCode(String numericCode);
  Future<void> deleteAllCurrencies();
}