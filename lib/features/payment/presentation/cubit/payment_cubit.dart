import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/payment/export_payment.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  final ProcessPaymentUseCase _processPaymentUseCase;

  // Form key
  final formKey = GlobalKey<FormState>();

  // Form controllers
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController(text: '4111111111111111');
  final cardMonthController = TextEditingController(text: '12');
  final cardYearController = TextEditingController(text: '2030');
  final cardCvcController = TextEditingController(text: '123');

  PaymentCubit(this._processPaymentUseCase) : super(const PaymentState());

  void submitPayment() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final request = PaymentRequest(
      givenId: const Uuid().v4(),
      amount: 19900, // Fixed amount for now
      callbackUrl: 'https://example.com/checkout/payer-return',
      source: PaymentSource(
        name: cardNameController.text.trim(),
        number: cardNumberController.text.trim().replaceAll(' ', ''),
        month: int.parse(cardMonthController.text.trim()),
        year: int.parse(cardYearController.text.trim()),
        cvc: int.parse(cardCvcController.text.trim()),
      ),
      metadata: const PaymentMetadata(
        cartId: '1102',
        customerEmail: 'abdulazizadel@gmail.com',
        customerId: '1102',
      ),
    );

    processPayment(request);
  }

  Future<void> processPayment(PaymentRequest request) async {
    emit(const PaymentState(status: PaymentStatus.loading));

    final result = await _processPaymentUseCase(request);

    result.when(
      (response) {
        if (response.requiresAuthentication) {
          emit(
            PaymentState(
              status: PaymentStatus.requiresAuth,
              response: response,
              authUrl: response.source.transactionUrl,
            ),
          );
        } else {
          emit(PaymentState(status: PaymentStatus.success, response: response));
        }
      },
      (failure) {
        emit(
          PaymentState(
            status: PaymentStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  void reset() {
    emit(const PaymentState());
  }

  @override
  Future<void> close() {
    cardNameController.dispose();
    cardNumberController.dispose();
    cardMonthController.dispose();
    cardYearController.dispose();
    cardCvcController.dispose();
    return super.close();
  }
}
