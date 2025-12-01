// lib/features/company_portal/presentation/pages/payment_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  void _handlePaymentSuccess(BuildContext context) {
    // 💡 NOTE: This should ideally be triggered by a BLoC state change
    // (e.g., PaymentCubit or CompanyBloc emits PaymentSuccessfulState)

    // For now, simulating success routing:
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment successful! Welcome aboard.')),
    );
    // In PaymentPage's BlocListener:
    context.goNamed('company-search');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription Payment')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.credit_card, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 24),
              const Text(
                'Unlock all features with a subscription.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Simulating the payment action button
              ElevatedButton(
                onPressed: () => _handlePaymentSuccess(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Proceed to Pay \$99'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
