import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'insights_state.dart';

class InsightsCubit extends Cubit<InsightsState> {
  InsightsCubit() : super(InsightsInitial());
}
