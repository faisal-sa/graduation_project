import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/usecases/add_certification_usecase.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/usecases/delete_certification_usecase.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/usecases/get_certifications_usecase.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/usecases/update_certification_usecase.dart';
import 'package:graduation_project/features/individuals/features/certifications/presentation/cubit/certification_state.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/cubit/work_experience_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class CertificationCubit extends Cubit<CertificationState> {
  final GetCertificationsUseCase _getCertificationsUseCase;
  final DeleteCertificationUseCase _deleteCertificationUseCase;
  final AddCertificationUseCase _addCertificationUseCase;
  final UpdateCertificationUseCase _updateCertificationUseCase;

  CertificationCubit(
    this._getCertificationsUseCase,
    this._deleteCertificationUseCase,
    this._addCertificationUseCase,
    this._updateCertificationUseCase,
  ) : super(const CertificationState());

  Future<void> loadCertifications() async {
    emit(const CertificationState(status: ListStatus.loading));
    try {
      final list = await _getCertificationsUseCase();
      emit(
        CertificationState(status: ListStatus.success, certifications: list),
      );
    } catch (e) {
      emit(
        CertificationState(
          status: ListStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> addCertification(Certification certification) async {
    try {
      await _addCertificationUseCase(certification);
      final currentList = List<Certification>.from(state.certifications);
      currentList.add(certification);
      emit(state.copyWith(certifications: currentList));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateCertification(Certification certification) async {
    try {
      await _updateCertificationUseCase(certification);
      final currentList = List<Certification>.from(state.certifications);
      final index = currentList.indexWhere((e) => e.id == certification.id);
      if (index != -1) {
        currentList[index] = certification;
        emit(state.copyWith(certifications: currentList));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteCertification(String id) async {
    try {
      await _deleteCertificationUseCase(id);
      final currentList = List<Certification>.from(state.certifications);
      currentList.removeWhere((e) => e.id == id);
      emit(state.copyWith(certifications: currentList));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
