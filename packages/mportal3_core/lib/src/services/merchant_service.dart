import '../models.dart';

abstract class MerchantService {
  Future<Merchant?> getCurrentMerchant();
  Future<Merchant?> getMerchantByLogin(String login);
}