import 'package:mp3_mobile_app/domain/models.dart';

class AccessibleMerchantDto {
  final String merchantLogin;
  final String merchantFullName;
  final String merchantType;
  final String sessionTokenHash;

  const AccessibleMerchantDto({
    required this.merchantLogin,
    required this.merchantFullName,
    required this.merchantType,
    required this.sessionTokenHash,
  });

  factory AccessibleMerchantDto.fromModel({
    required AccessibleMerchant model,
    required String sessionTokenHash,
  }) {
    return AccessibleMerchantDto(
      merchantLogin: model.merchantLogin,
      merchantFullName: model.merchantFullName,
      merchantType: model.merchantType.name,
      sessionTokenHash: sessionTokenHash,
    );
  }

  AccessibleMerchant toModel() {
    var tempMerchantType = MerchantType.unknown;
    try {
      tempMerchantType = MerchantType.values.byName(merchantType);
    } on ArgumentError {
      //TODO: logging
    }

    return AccessibleMerchant(
      merchantLogin: merchantLogin,
      merchantFullName: merchantFullName,
      merchantType: tempMerchantType,
    );
  }
}

abstract class AccessibleMerchantsDao {
  Future<List<AccessibleMerchantDto>> getAccessibleMerchantsBySession(
    String sessionId,
  );
  Future<List<AccessibleMerchantDto>> getAllAccessibleMerchants();
  Future<void> saveAccessibleMerchants(List<AccessibleMerchantDto> merchants);
  Future<void> deleteAccessibleMerchantsBySession(String sessionId);
  Future<void> deleteAllAccessibleMerchants();
}
