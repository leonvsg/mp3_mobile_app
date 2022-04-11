import 'package:equatable/equatable.dart';

enum MerchantType { parent,child,viewable,unknown }

class AccessibleMerchant extends Equatable{
  final String merchantLogin;
  final String merchantFullName;
  final MerchantType merchantType;

  const AccessibleMerchant({
    required this.merchantLogin,
    required this.merchantFullName,
    required this.merchantType,
  });

  @override
  List<Object?> get props => [merchantLogin,merchantFullName,merchantType];

  @override
  bool get stringify => true;
}