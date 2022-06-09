import 'package:freezed_annotation/freezed_annotation.dart';

import 'accessible_merchant.dart';
import 'enums.dart';
import 'merchant.dart';

part 'session.freezed.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required final String sessionId,
    required final String userLogin,
    required final Merchant merchant,
    required final List<AccessibleMerchant> accessibleMerchants,
    required final List<UserPermission> permissions,
  }) = _Session;
}
