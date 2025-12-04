import 'package:graduation_project/features/payment/export_payment.dart';

class PaymentSourceModel extends PaymentSource {
  const PaymentSourceModel({
    super.type,
    required super.name,
    required super.number,
    required super.month,
    required super.year,
    required super.cvc,
    super.statementDescriptor,
    super.threeDS,
    super.manual,
    super.saveCard,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'number': number,
      'month': month,
      'year': year,
      'cvc': cvc,
      'statement_descriptor': statementDescriptor,
      '3ds': threeDS,
      'manual': manual,
      'save_card': saveCard,
    };
  }

  factory PaymentSourceModel.fromEntity(PaymentSource source) {
    return PaymentSourceModel(
      type: source.type,
      name: source.name,
      number: source.number,
      month: source.month,
      year: source.year,
      cvc: source.cvc,
      statementDescriptor: source.statementDescriptor,
      threeDS: source.threeDS,
      manual: source.manual,
      saveCard: source.saveCard,
    );
  }
}
