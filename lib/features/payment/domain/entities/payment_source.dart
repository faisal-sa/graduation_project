import 'package:equatable/equatable.dart';

class PaymentSource extends Equatable {
  final String type;
  final String name;
  final String number;
  final int month;
  final int year;
  final int cvc;
  final String statementDescriptor;
  final bool threeDS;
  final bool manual;
  final bool saveCard;

  const PaymentSource({
    this.type = 'creditcard',
    required this.name,
    required this.number,
    required this.month,
    required this.year,
    required this.cvc,
    this.statementDescriptor = 'Century Store',
    this.threeDS = true,
    this.manual = false,
    this.saveCard = false,
  });

  @override
  List<Object?> get props => [
        type,
        name,
        number,
        month,
        year,
        cvc,
        statementDescriptor,
        threeDS,
        manual,
        saveCard,
      ];
}

