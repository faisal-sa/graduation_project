import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/features/basic_info/domain/entities/basic_info_entity.dart';
import 'package:graduation_project/features/individuals/features/basic_info/domain/usecases/save_basic_info_usecase.dart';
import 'package:injectable/injectable.dart';

part 'basic_info_state.dart';

@injectable
class BasicInfoCubit extends Cubit<BasicInfoState> {
  final SaveBasicInfoUseCase _saveBasicInfoUseCase;

  BasicInfoCubit(this._saveBasicInfoUseCase) : super(const BasicInfoState());

  Future<void> saveForm({
    required String firstName,
    required String lastName,
    required String jobTitle,
    required String phoneNumber,
    required String email,
    required String location,
  }) async {
    if (state.status == FormStatus.loading) return;

    emit(state.copyWith(status: FormStatus.loading));

    try {
      final entity = BasicInfoEntity(
        firstName: firstName,
        lastName: lastName,
        jobTitle: jobTitle,
        phoneNumber: phoneNumber,
        email: email,
        location: location,
      );

      await _saveBasicInfoUseCase(entity);

      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
