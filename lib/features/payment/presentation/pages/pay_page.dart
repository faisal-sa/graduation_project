import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/payment/export_payment.dart';

class PayPage extends StatelessWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a very subtle off-white for the whole page
      backgroundColor: Colors.grey[50],

      //==================  App Bar  =================== //
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        centerTitle: true,
        elevation: 0,
        // Matching the dark brand color from your previous TextField focused border
        backgroundColor: const Color.fromARGB(255, 249, 249, 250),
        foregroundColor: Colors.black,
      ),

      //==================  Body  ===================//
      body: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) async {
          // Logic preserved exactly as requested
          switch (state.status) {
            case PaymentStatus.requiresAuth:
              if (state.authUrl != null) {
                final bool? webViewResult = await context.push<bool>(
                  '/payment-webview?url=${Uri.encodeComponent(state.authUrl!)}',
                );

                if (webViewResult == true && context.mounted) {
                  context.pop(true);
                }
              }
              break;

            case PaymentStatus.success:
              final response = state.response!;
              if (response.isPaid) {
                AppSnackbar.success(context, 'Payment Successful');
                if (context.canPop()) {
                  context.pop(true);
                } else {
                  context.go('/company/search');
                }
              } else {
                AppSnackbar.warning(context, 'Payment Failed');
              }
              break;

            case PaymentStatus.initial:
              throw UnimplementedError();
            case PaymentStatus.loading:
              throw UnimplementedError();
            case PaymentStatus.failure:
              throw UnimplementedError();
          }
        },
        //==================  Main Widget  ===================//
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //==================  Payment amount  ===================//
              payTitleWidget('199 SAR'),
              const SizedBox(height: 24),

              //==================  Credit Card Widget  ===================//
              creditCardWidget(context),
              const SizedBox(height: 24),

              //==================  Card Details  ===================//
              buildSectionTitle('Card Details'),

              //==================  Card Input Form  ===================//
              // Assuming this form uses the FormTextField we styled previously
              const CardInputForm(),
              const SizedBox(height: 40),

              //==================  BlocBuilder for Pay Now Button  ===================//
              BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
                  final isLoading = state.status == PaymentStatus.loading;

                  //==================  Pay Now Button  ===================//
                  return SizedBox(
                    height: 56, // Taller, more modern button
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : context.read<PaymentCubit>().submitPayment,
                      style: ElevatedButton.styleFrom(
                        // Dark Navy Brand Color
                        backgroundColor: const Color.fromARGB(
                          255,
                          123,
                          43,
                          181,
                        ),
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: const Color.fromARGB(66, 24, 1, 74),
                        disabledBackgroundColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          //==================  Pay Now Button Loading  ===================//
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          // ==================  Pay Now Button Text  =================== //
                          : const Text(
                              'Pay Now',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  );
                },
              ),
              // Extra padding at bottom for scrolling
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
