//=========//
// CardInputForm widget for collecting payment/card info. Includes amount, cardholder, number, expiry, and CVC.
//=========//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/payment/export_payment.dart';

//=========//
// Stateless widget for the card/payment input form.
//=========//
class CardInputForm extends StatelessWidget {
  const CardInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PaymentCubit>();
    //=========//
    // Main form structure.
    //=========//
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //=========//
          // Card section
          //=========//
          FormTextField(
            controller: cubit.cardNameController,
            label: 'Cardholder Name',
            hint: 'Abdulaziz Adel',
            validator: (value) {
              //=========//
              // Validate name: required, only letters/spaces, min length 2.
              //=========//
              if (value == null || value.isEmpty) {
                return 'Please enter cardholder name';
              }
              final nameRegEx = RegExp(r"^[a-zA-Z ]+$");
              if (!nameRegEx.hasMatch(value)) {
                return 'Name must contain only letters';
              }
              if (value.trim().length < 2) {
                return 'Name too short';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          FormTextField(
            controller: cubit.cardNumberController,
            label: 'Card Number',
            hint: '4242 4242 4242 4242',
            keyboardType: TextInputType.number,
            validator: (value) {
              //=========//
              // Validate card number: required, 13-19 digits, numeric.
              //=========//
              if (value == null || value.isEmpty) {
                return 'Please enter card number';
              }
              final sanitized = value.replaceAll(' ', '');
              if (sanitized.length < 13 || sanitized.length > 19) {
                return 'Please enter a valid card number';
              }
              if (!RegExp(r'^\d{13,19}$').hasMatch(sanitized)) {
                return 'Card number must be numeric';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  controller: cubit.cardMonthController,
                  label: 'Month',
                  hint: '12',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    //=========//
                    // Validate month: required, 1-12.
                    //=========//
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    final month = int.tryParse(value);
                    if (month == null || month < 1 || month > 12) {
                      return 'Invalid';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FormTextField(
                  controller: cubit.cardYearController,
                  label: 'Year',
                  hint: '2030',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    //=========//
                    // Validate year: required, ≥currentYear, ≤currentYear+20.
                    //=========//
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    final year = int.tryParse(value);
                    final currentYear = DateTime.now().year;
                    if (year == null) {
                      return 'Invalid';
                    }
                    if (year < currentYear) {
                      return 'Expired';
                    }
                    if (year > currentYear + 20) {
                      return 'Too far in future';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FormTextField(
                  controller: cubit.cardCvcController,
                  label: 'CVC',
                  hint: '123',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    //=========//
                    // Validate CVC: required, 3 or 4 digits.
                    //=========//
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
                      return 'Invalid CVC';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
