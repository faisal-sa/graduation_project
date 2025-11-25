import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'basic_information_state.dart';

class BasicInformationCubit extends Cubit<BasicInformationState> {
  BasicInformationCubit() : super(BasicInformationInitial());
}
