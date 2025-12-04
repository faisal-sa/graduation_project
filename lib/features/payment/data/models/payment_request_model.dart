import 'package:graduation_project/features/payment/export_payment.dart';

class PaymentRequestModel {
  final String givenId;
  final int amount;
  final String currency;
  final String description;
  final String callbackUrl;
  final PaymentSourceModel source;
  final PaymentMetadataModel metadata;
  final bool applyCoupon;

  const PaymentRequestModel({
    required this.givenId,
    required this.amount,
    this.currency = 'SAR',
    this.description = 'Payment',
    required this.callbackUrl,
    required this.source,
    required this.metadata,
    this.applyCoupon = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'given_id': givenId,
      'amount': amount,
      'currency': currency,
      'description': description,
      'callback_url': callbackUrl,
      'source': source.toJson(),
      'metadata': metadata.toJson(),
      'apply_coupon': applyCoupon,
    };
  }

  factory PaymentRequestModel.fromEntity(PaymentRequest request) {
    return PaymentRequestModel(
      givenId: request.givenId,
      amount: request.amount,
      currency: request.currency,
      description: request.description,
      callbackUrl: request.callbackUrl,
      source: PaymentSourceModel.fromEntity(request.source),
      metadata: PaymentMetadataModel.fromEntity(request.metadata),
      applyCoupon: request.applyCoupon,
    );
  }
}
