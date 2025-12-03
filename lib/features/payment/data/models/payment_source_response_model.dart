import 'package:graduation_project/features/payment/export_payment.dart';

class PaymentSourceResponseModel extends PaymentSourceResponse {
  const PaymentSourceResponseModel({
    required super.type,
    super.company,
    required super.name,
    required super.number,
    super.gatewayId,
    super.referenceNumber,
    super.token,
    super.message,
    super.transactionUrl,
    super.responseCode,
    super.authorizationCode,
    super.issuerName,
    super.issuerCountry,
    super.issuerCardType,
    super.issuerCardCategory,
  });

  factory PaymentSourceResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentSourceResponseModel(
      type: json['type'] as String? ?? '',
      company: json['company'] as String?,
      name: json['name'] as String? ?? '',
      number: json['number'] as String? ?? '',
      gatewayId: json['gateway_id'] as String?,
      referenceNumber: json['reference_number'] as String?,
      token: json['token'] as String?,
      message: json['message'] as String?,
      transactionUrl: json['transaction_url'] as String?,
      responseCode: json['response_code'] as String?,
      authorizationCode: json['authorization_code'] as String?,
      issuerName: json['issuer_name'] as String?,
      issuerCountry: json['issuer_country'] as String?,
      issuerCardType: json['issuer_card_type'] as String?,
      issuerCardCategory: json['issuer_card_category'] as String?,
    );
  }
}
