import 'package:graduation_project/features/payment/export_payment.dart';

class PaymentMetadataModel extends PaymentMetadata {
  const PaymentMetadataModel({
    required super.cartId,
    required super.customerEmail,
    required super.customerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cartId,
      'customer_email': customerEmail,
      'customer_id': customerId,
    };
  }

  factory PaymentMetadataModel.fromJson(Map<String, dynamic> json) {
    return PaymentMetadataModel(
      cartId: json['cart_id'] as String? ?? '',
      customerEmail: json['customer_email'] as String? ?? '',
      customerId: json['customer_id'] as String? ?? '',
    );
  }

  factory PaymentMetadataModel.fromEntity(PaymentMetadata metadata) {
    return PaymentMetadataModel(
      cartId: metadata.cartId,
      customerEmail: metadata.customerEmail,
      customerId: metadata.customerId,
    );
  }
}
