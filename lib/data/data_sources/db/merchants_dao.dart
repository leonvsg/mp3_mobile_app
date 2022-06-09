import 'package:mp3_client_core/mp3_client_core.dart';

abstract class MerchantsDao {
  Future<Merchant> getMerchant(String login);
  Future<void> saveOrUpdateMerchant(Merchant merchant);
  Future<void> deleteMerchant(String login);
  Future<void> deleteAllMerchants();
}
