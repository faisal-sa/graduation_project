part of 'basic_info_cubit.dart';

enum FormStatus { initial, loading, success, failure }

class BasicInfoState extends Equatable {
  final FormStatus status;

  const BasicInfoState({this.status = FormStatus.initial});

  BasicInfoState copyWith({FormStatus? status}) {
    return BasicInfoState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
