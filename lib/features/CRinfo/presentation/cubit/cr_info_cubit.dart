import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_cr_info.dart';
import 'cr_info_state.dart';

@injectable
class CrInfoCubit extends Cubit<CrInfoState> {
  final GetCrInfo getCrInfo;

  CrInfoCubit({required this.getCrInfo}) : super(CrInfoInitial());

  Future<void> fetchCrInfo(String crNumber) async {
    if (crNumber.trim().isEmpty) {
      emit(const CrInfoError("يرجى إدخال رقم السجل التجاري"));
      return;
    }

    emit(CrInfoLoading());

    try {
      final crInfo = await getCrInfo(crNumber);
      emit(CrInfoLoaded(crInfo));
    } catch (e) {
      print(e);
      final errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : "خطأ في جلب البيانات";

      emit(CrInfoError(errorMessage));
    }
  }

  void reset() {
    emit(CrInfoInitial());
  }
}
