import 'package:equatable/equatable.dart';

import 'accessible_merchant.dart';
import 'enums.dart';
import 'merchant.dart';

class Session extends Equatable {
  final String sessionId;
  final String userLogin;
  final Merchant merchant;
  final List<AccessibleMerchant> accessibleMerchants;
  final List<UserPermission> permissions;

  const Session({
    required this.sessionId,
    required this.userLogin,
    required this.merchant,
    required this.accessibleMerchants,
    required this.permissions,
  });

  @override
  List<Object?> get props => [sessionId, userLogin, merchant, accessibleMerchants, permissions];

  @override
  bool get stringify => true;
}
