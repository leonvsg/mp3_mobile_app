import 'database.dart';

class MerchantDto {
  final Merchant merchant;
  final List<int> currencies;
  final List<int> terms;
  final List<int> locales;
  final List<String> permissions;

  const MerchantDto({
    required this.merchant,
    required this.currencies,
    required this.terms,
    required this.locales,
    required this.permissions,
  });
}

abstract class MerchantsDao {

  Future<MerchantDto> getMerchant(String login);
  Future<List<MerchantDto>> getAllMerchants();
  Future<void> saveOrUpdateMerchant(MerchantDto merchant);
  Future<void> deleteMerchant(String login);
  Future<void> deleteAllMerchants();
}