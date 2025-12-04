import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:u_credit_card/u_credit_card.dart';

/*

This widget is used to display the credit card information.
for ducomentation, see the link: https://pub.dev/packages/u_credit_card.
it can be customized as you want.
also enable the flipping effect to see the back of the card.
*/

Widget creditCardWidget(BuildContext context) {
  final cubit = context.read<PaymentCubit>();
  return CreditCardUi(
    cardHolderFullName: cubit.cardNameController.text,
    cardNumber: cubit.cardNumberController.text,
    validFrom: cubit.cardMonthController.text,
    validThru: cubit.cardYearController.text,
    topLeftColor: Colors.blue,
    bottomRightColor: Colors.purple,
    enableFlipping: true,
  );
}
