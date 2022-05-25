import 'package:mp3_mobile_app/domain/models.dart';

abstract class MerchantsDao {
  Future<Merchant> getMerchant(String login);
  Future<void> saveOrUpdateMerchant(Merchant merchant);
  Future<void> deleteMerchant(String login);
  Future<void> deleteAllMerchants();
}
