import 'package:equatable/equatable.dart';
import 'payment_metadata.dart';
import 'payment_source_response.dart';

class PaymentResponse extends Equatable {
  final String id;
  final String status;
  final int amount;
  final int fee;
  final String currency;
  final int refunded;
  final String? refundedAt;
  final int captured;
  final String? capturedAt;
  final String? voidedAt;
  final String description;
  final String amountFormat;
  final String feeFormat;
  final String refundedFormat;
  final String capturedFormat;
  final String? invoiceId;
  final String ip;
  final String callbackUrl;
  final String createdAt;
  final String updatedAt;
  final PaymentMetadata metadata;
  final PaymentSourceResponse source;
  final List<dynamic> splits;

  const PaymentResponse({
    required this.id,
    required this.status,
    required this.amount,
    required this.fee,
    required this.currency,
    required this.refunded,
    this.refundedAt,
    required this.captured,
    this.capturedAt,
    this.voidedAt,
    required this.description,
    required this.amountFormat,
    required this.feeFormat,
    required this.refundedFormat,
    required this.capturedFormat,
    this.invoiceId,
    required this.ip,
    required this.callbackUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.metadata,
    required this.source,
    required this.splits,
  });

  bool get isPaid => status == 'paid';
  bool get requiresAuthentication =>
      source.transactionUrl != null && source.transactionUrl!.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        status,
        amount,
        fee,
        currency,
        refunded,
        refundedAt,
        captured,
        capturedAt,
        voidedAt,
        description,
        amountFormat,
        feeFormat,
        refundedFormat,
        capturedFormat,
        invoiceId,
        ip,
        callbackUrl,
        createdAt,
        updatedAt,
        metadata,
        source,
        splits,
      ];
}

