import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/payment/export_payment.dart';

enum PaymentStatus { initial, loading, success, requiresAuth, failure }

class PaymentState extends Equatable {
  final PaymentStatus status;
  final PaymentResponse? response;
  final String? errorMessage;
  final String? authUrl;

  const PaymentState({
    this.status = PaymentStatus.initial,
    this.response,
    this.errorMessage,
    this.authUrl,
  });

  PaymentState copyWith({
    PaymentStatus? status,
    PaymentResponse? response,
    String? errorMessage,
    String? authUrl,
  }) {
    return PaymentState(
      status: status ?? this.status,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
      authUrl: authUrl ?? this.authUrl,
    );
  }

  @override
  List<Object?> get props => [status, response, errorMessage, authUrl];
}
