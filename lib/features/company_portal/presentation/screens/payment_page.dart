import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💳 الدفع')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'أكمل عملية الدفع لتفعيل حساب شركتك',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.payments),
                label: const Text('الدفع الآن'),
                onPressed: () {
                  // هنا من المفترض تنفيذ الدفع الحقيقي (Stripe أو غيره)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('✅ تم الدفع بنجاح')),
                  );
                  context.pushReplacement('/company/search');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
