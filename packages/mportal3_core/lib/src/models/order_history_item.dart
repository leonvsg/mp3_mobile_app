import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'order_history_item.freezed.dart';

@freezed
class OrderHistoryItem with _$OrderHistoryItem {
  const factory OrderHistoryItem({
    required HistoryItemType type,
    required DateTime date,
    required String shortDescription,
    required String fullDescription,
    required bool successful,
  }) = _OrderHistoryItem;
}
