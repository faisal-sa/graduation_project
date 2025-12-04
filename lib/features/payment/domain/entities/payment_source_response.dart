import 'package:equatable/equatable.dart';

class PaymentSourceResponse extends Equatable {
  final String type;
  final String? company;
  final String name;
  final String number;
  final String? gatewayId;
  final String? referenceNumber;
  final String? token;
  final String? message;
  final String? transactionUrl;
  final String? responseCode;
  final String? authorizationCode;
  final String? issuerName;
  final String? issuerCountry;
  final String? issuerCardType;
  final String? issuerCardCategory;

  const PaymentSourceResponse({
    required this.type,
    this.company,
    required this.name,
    required this.number,
    this.gatewayId,
    this.referenceNumber,
    this.token,
    this.message,
    this.transactionUrl,
    this.responseCode,
    this.authorizationCode,
    this.issuerName,
    this.issuerCountry,
    this.issuerCardType,
    this.issuerCardCategory,
  });

  @override
  List<Object?> get props => [
        type,
        company,
        name,
        number,
        gatewayId,
        referenceNumber,
        token,
        message,
        transactionUrl,
        responseCode,
        authorizationCode,
        issuerName,
        issuerCountry,
        issuerCardType,
        issuerCardCategory,
      ];
}

