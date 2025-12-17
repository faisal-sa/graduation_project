import 'package:graduation_project/core/exports/app_exports.dart';
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
      debugPrint(e.toString());
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
