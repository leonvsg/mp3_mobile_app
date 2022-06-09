import 'package:mp3_client_core/mp3_client_core.dart';

abstract class MerchantRepository {
  Future<Merchant?> getCurrentMerchant();
  Future<Merchant?> getMerchantByLogin(String login);
}