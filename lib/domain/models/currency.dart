import 'package:equatable/equatable.dart';

class Currency extends Equatable{
  final String alphabeticCode;
  final int minorUnit;
  final String? numericCode;
  final String? name;

  const Currency({
    required this.alphabeticCode,
    required this.minorUnit,
    this.numericCode,
    this.name,
  });

  @override
  List<Object?> get props => [alphabeticCode,minorUnit];

  @override
  bool get stringify => true;
}
