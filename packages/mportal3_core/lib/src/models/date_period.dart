import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_period.freezed.dart';

@freezed
class DatePeriod with _$DatePeriod {
  const factory DatePeriod({
    required final DateTime from,
    required final DateTime to,
  }) = _DatePeriod;
}
