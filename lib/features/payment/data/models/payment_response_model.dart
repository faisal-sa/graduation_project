import 'package:graduation_project/features/payment/export_payment.dart';

class PaymentResponseModel extends PaymentResponse {
  const PaymentResponseModel({
    required super.id,
    required super.status,
    required super.amount,
    required super.fee,
    required super.currency,
    required super.refunded,
    super.refundedAt,
    required super.captured,
    super.capturedAt,
    super.voidedAt,
    required super.description,
    required super.amountFormat,
    required super.feeFormat,
    required super.refundedFormat,
    required super.capturedFormat,
    super.invoiceId,
    required super.ip,
    required super.callbackUrl,
    required super.createdAt,
    required super.updatedAt,
    required super.metadata,
    required super.source,
    required super.splits,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      id: json['id'] as String? ?? '',
      status: json['status'] as String? ?? '',
      amount: json['amount'] as int? ?? 0,
      fee: json['fee'] as int? ?? 0,
      currency: json['currency'] as String? ?? '',
      refunded: json['refunded'] as int? ?? 0,
      refundedAt: json['refunded_at'] as String?,
      captured: json['captured'] as int? ?? 0,
      capturedAt: json['captured_at'] as String?,
      voidedAt: json['voided_at'] as String?,
      description: json['description'] as String? ?? '',
      amountFormat: json['amount_format'] as String? ?? '',
      feeFormat: json['fee_format'] as String? ?? '',
      refundedFormat: json['refunded_format'] as String? ?? '',
      capturedFormat: json['captured_format'] as String? ?? '',
      invoiceId: json['invoice_id'] as String?,
      ip: json['ip'] as String? ?? '',
      callbackUrl: json['callback_url'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      metadata: PaymentMetadataModel.fromJson(
        json['metadata'] as Map<String, dynamic>? ?? {},
      ),
      source: PaymentSourceResponseModel.fromJson(
        json['source'] as Map<String, dynamic>? ?? {},
      ),
      splits: json['splits'] as List<dynamic>? ?? [],
    );
  }
}
