import 'package:equatable/equatable.dart';

import 'accessible_merchant.dart';
import 'merchant.dart';

class Session extends Equatable {
  final String sessionId;
  final String userLogin;
  final Merchant merchant;
  final List<AccessibleMerchant> accessibleMerchants;

  const Session({
    required this.sessionId,
    required this.userLogin,
    required this.merchant,
    required this.accessibleMerchants,
  });

  @override
  List<Object?> get props => [sessionId, userLogin, merchant, accessibleMerchants];

  @override
  bool get stringify => true;
}
