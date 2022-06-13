import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'loyalty_history_item.freezed.dart';

@freezed
class LoyaltyHistoryItem with _$LoyaltyHistoryItem {
  const factory LoyaltyHistoryItem({
    LoyaltyService? loyaltyService,
    int? loyaltyAward,
    int? loyaltyPayment,
  }) = _LoyaltyHistoryItem;
}
