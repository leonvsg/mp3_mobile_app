import 'package:equatable/equatable.dart';

class Currency extends Equatable{
  final String alphabeticCode;
  final int minorUnit;

  const Currency({
    required this.alphabeticCode,
    required this.minorUnit,
  });

  @override
  List<Object?> get props => [alphabeticCode,minorUnit];

  @override
  bool get stringify => true;
}
