import 'package:flutter/material.dart';

// This file contains widgets for displaying the payment title and amount.

Widget payTitleWidget(String amount) {
  // can be controle frome the pay_page.dart
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
      color: Colors.blue.withAlpha(20),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.blue.withAlpha(40)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 12),
        Text(
          'Payment amount:',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 12),

        Text(
          amount,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );
}
