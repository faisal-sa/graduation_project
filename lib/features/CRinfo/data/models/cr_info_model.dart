import 'package:equatable/equatable.dart';
import '../../domain/entities/cr_info.dart';
import 'entity_type_model.dart';
import 'status_model.dart';
import 'activity_model.dart';

class CrInfoModel extends Equatable {
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
  final EntityTypeModel entityType;
  final StatusModel status;
  final List<ActivityModel> activities;

  const CrInfoModel({
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

  factory CrInfoModel.fromJson(Map<String, dynamic> json) {
    return CrInfoModel(
      crNationalNumber: json['crNationalNumber'] as String,
      crNumber: json['crNumber'] as String,
      versionNo: json['versionNo'] as int,
      name: json['name'] as String,
      companyDuration: json['companyDuration'] as String?,
      isMain: json['isMain'] as bool,
      issueDateGregorian: json['issueDateGregorian'] as String,
      issueDateHijri: json['issueDateHijri'] as String,
      mainCrNationalNumber: json['mainCrNationalNumber'] as String?,
      mainCrNumber: json['mainCrNumber'] as String?,
      inLiquidationProcess: json['inLiquidationProcess'] as bool,
      hasEcommerce: json['hasEcommerce'] as bool,
      headquarterCityId: json['headquarterCityId'] as int,
      headquarterCityName: json['headquarterCityName'] as String,
      isLicenseBased: json['isLicenseBased'] as bool,
      entityType: EntityTypeModel.fromJson(
        json['entityType'] as Map<String, dynamic>,
      ),
      status: StatusModel.fromJson(json['status'] as Map<String, dynamic>),
      activities: (json['activities'] as List<dynamic>)
          .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  CrInfo toEntity() {
    return CrInfo(
      crNationalNumber: crNationalNumber,
      crNumber: crNumber,
      versionNo: versionNo,
      name: name,
      companyDuration: companyDuration,
      isMain: isMain,
      issueDateGregorian: issueDateGregorian,
      issueDateHijri: issueDateHijri,
      mainCrNationalNumber: mainCrNationalNumber,
      mainCrNumber: mainCrNumber,
      inLiquidationProcess: inLiquidationProcess,
      hasEcommerce: hasEcommerce,
      headquarterCityId: headquarterCityId,
      headquarterCityName: headquarterCityName,
      isLicenseBased: isLicenseBased,
      entityType: entityType.toEntity(),
      status: status.toEntity(),
      activities: activities.map((e) => e.toEntity()).toList(),
    );
  }

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
