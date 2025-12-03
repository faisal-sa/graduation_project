import 'package:graduation_project/core/error/failures.dart';
import 'package:graduation_project/features/payment/export_payment.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@LazySingleton(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource _remoteDataSource;

  PaymentRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<PaymentResponse, Failure>> processPayment(
    PaymentRequest request,
  ) async {
    try {
      final requestModel = PaymentRequestModel.fromEntity(request);
      final response = await _remoteDataSource.processPayment(requestModel);
      return Success(response);
    } catch (e) {
      return Error(ServerFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
