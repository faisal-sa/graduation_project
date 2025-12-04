import 'package:equatable/equatable.dart';
import 'entity_type.dart';
import 'status.dart';
import 'activity.dart';

class CrInfo extends Equatable {
  final String crNationalNumber;
  final String crNumber;
  final int versionNo;
  final String name;
  final String? companyDuration;
  final bool isMain;
  final String issueDateGregorian;
  final String issueDateHijri;
  final String? mainCrNationalNumber;
  final String? mainCrNumber;
  final bool inLiquidationProcess;
  final bool hasEcommerce;
  final int headquarterCityId;
  final String headquarterCityName;
  final bool isLicenseBased;
  final EntityType entityType;
  final Status status;
  final List<Activity> activities;

  const CrInfo({
    required this.crNationalNumber,
    required this.crNumber,
    required this.versionNo,
    required this.name,
    this.companyDuration,
    required this.isMain,
    required this.issueDateGregorian,
    required this.issueDateHijri,
    this.mainCrNationalNumber,
    this.mainCrNumber,
    required this.inLiquidationProcess,
    required this.hasEcommerce,
    required this.headquarterCityId,
    required this.headquarterCityName,
    required this.isLicenseBased,
    required this.entityType,
    required this.status,
    required this.activities,
  });

  @override
  List<Object?> get props => [
        crNationalNumber,
        crNumber,
        versionNo,
        name,
        companyDuration,
        isMain,
        issueDateGregorian,
        issueDateHijri,
        mainCrNationalNumber,
        mainCrNumber,
        inLiquidationProcess,
        hasEcommerce,
        headquarterCityId,
        headquarterCityName,
        isLicenseBased,
        entityType,
        status,
        activities,
      ];
}

