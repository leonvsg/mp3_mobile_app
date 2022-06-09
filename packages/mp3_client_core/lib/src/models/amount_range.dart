import 'package:freezed_annotation/freezed_annotation.dart';

part 'amount_range.freezed.dart';

@freezed
class AmountRange with _$AmountRange {
  @Assert('minAmount >= 0')
  @Assert('maxAmount >= 0')
  const factory AmountRange({
    required final int minAmount,
    required final int maxAmount,
  }) = _AmountRange;
}
