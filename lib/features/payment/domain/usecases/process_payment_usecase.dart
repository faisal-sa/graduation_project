import 'package:graduation_project/core/error/failures.dart';
import 'package:graduation_project/core/usecasesAbstract/usecase.dart';
import 'package:graduation_project/features/payment/export_payment.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@lazySingleton
class ProcessPaymentUseCase
    implements UseCase<PaymentResponse, PaymentRequest> {
  final PaymentRepository _repository;

  ProcessPaymentUseCase(this._repository);

  @override
  Future<Result<PaymentResponse, Failure>> call(PaymentRequest params) {
    return _repository.processPayment(params);
  }
}
