import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:mp3_mobile_app/domain/models.dart';

class SessionDto {
  final String tokenHash;
  final String userLogin;
  final String merchantLogin;
  final DateTime registerTime;
  final bool isActive;

  const SessionDto({
    required this.tokenHash,
    required this.userLogin,
    required this.merchantLogin,
    required this.registerTime,
    required this.isActive,
  });

  factory SessionDto.fromModel(Session model) {
    var tokenHash = md5.convert(utf8.encode(model.sessionId)).toString();

    return SessionDto(
      tokenHash: tokenHash,
      userLogin: model.userLogin,
      merchantLogin: model.merchant.login,
      registerTime: DateTime.now(),
      isActive: true,
    );
  }

  Session toModel(String sessionId, Merchant merchant, List<AccessibleMerchant> accessibleMerchants) {
    return Session(sessionId: sessionId, userLogin: userLogin, merchant: merchant, accessibleMerchants: accessibleMerchants);
  }
}

abstract class SessionDao {
  Future<SessionDto> getSession(String tokenHash);
  Future<List<SessionDto>> getAllSessions();
  Future<void> saveOrUpdateSession(SessionDto session);
  Future<void> deleteSession(String tokenHash);
  Future<void> deleteAllSessions();
}
