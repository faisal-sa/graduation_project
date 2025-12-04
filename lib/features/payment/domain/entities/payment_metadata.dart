import 'package:equatable/equatable.dart';

class PaymentMetadata extends Equatable {
  final String cartId;
  final String customerEmail;
  final String customerId;

  const PaymentMetadata({
    required this.cartId,
    required this.customerEmail,
    required this.customerId,
  });

  @override
  List<Object?> get props => [cartId, customerEmail, customerId];
}

