import 'package:equatable/equatable.dart';
import 'payment_source.dart';
import 'payment_metadata.dart';

class PaymentRequest extends Equatable {
  final String givenId;
  final int amount;
  final String currency;
  final String description;
  final String callbackUrl;
  final PaymentSource source;
  final PaymentMetadata metadata;
  final bool applyCoupon;

  const PaymentRequest({
    required this.givenId,
    required this.amount,
    this.currency = 'SAR',
    this.description = 'Payment',
    required this.callbackUrl,
    required this.source,
    required this.metadata,
    this.applyCoupon = false,
  });

  @override
  List<Object?> get props => [
        givenId,
        amount,
        currency,
        description,
        callbackUrl,
        source,
        metadata,
        applyCoupon,
      ];
}

