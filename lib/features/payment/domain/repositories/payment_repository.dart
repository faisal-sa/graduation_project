import 'package:graduation_project/core/error/failures.dart';
import 'package:graduation_project/features/payment/export_payment.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class PaymentRepository {
  Future<Result<PaymentResponse, Failure>> processPayment(
    PaymentRequest request,
  );
}
