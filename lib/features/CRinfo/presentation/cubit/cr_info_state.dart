import 'package:equatable/equatable.dart';
import '../../domain/entities/cr_info.dart';

abstract class CrInfoState extends Equatable {
  const CrInfoState();

  @override
  List<Object?> get props => [];
}

class CrInfoInitial extends CrInfoState {}

class CrInfoLoading extends CrInfoState {}

class CrInfoLoaded extends CrInfoState {
  final CrInfo crInfo;

  const CrInfoLoaded(this.crInfo);

  @override
  List<Object?> get props => [crInfo];
}

class CrInfoError extends CrInfoState {
  final String message;

  const CrInfoError(this.message);

  @override
  List<Object?> get props => [message];
}
