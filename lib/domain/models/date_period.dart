import 'package:equatable/equatable.dart';

class DatePeriod extends Equatable {
  final DateTime from;
  final DateTime to;

  DatePeriod({
    required this.from,
    required this.to,
  }) : assert(to.isAfter(from),
  'date "to" should be later then "from". now: from - $from; to - $to.');

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [from, to];
}
