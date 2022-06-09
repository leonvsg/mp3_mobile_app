import 'package:mp3_client_core/mp3_client_core.dart';

abstract class CurrenciesDao {

  Future<Currency?> getCurrencyByAlphabeticCode(String alphabeticCode);
  Future<Currency?> getCurrencyByNumericCode(String numericCode);
  Future<List<Currency>> getAllCurrencies();
  Future<void> saveOrUpdateCurrency(Currency currency);
  Future<void> updateAllCurrencies(List<Currency> currencies);
  Future<void> deleteCurrencyByAlphabeticCode(String alphabeticCode);
  Future<void> deleteCurrencyByNumericCode(String numericCode);
  Future<void> deleteAllCurrencies();
}