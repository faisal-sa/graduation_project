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
    try {
      return CrInfoModel(
        crNationalNumber: json['crNationalNumber']?.toString() ?? '',
        crNumber: json['crNumber']?.toString() ?? '',
        versionNo: json['versionNo'] as int? ?? 0,
        name: json['name']?.toString() ?? '',
        companyDuration: json['companyDuration']?.toString(),
        isMain: json['isMain'] as bool? ?? false,
        issueDateGregorian: json['issueDateGregorian']?.toString() ?? '',
        issueDateHijri: json['issueDateHijri']?.toString() ?? '',
        mainCrNationalNumber: json['mainCrNationalNumber']?.toString(),
        mainCrNumber: json['mainCrNumber']?.toString(),
        inLiquidationProcess: json['inLiquidationProcess'] as bool? ?? false,
        hasEcommerce: json['hasEcommerce'] as bool? ?? false,
        headquarterCityId: json['headquarterCityId'] as int? ?? 0,
        headquarterCityName: json['headquarterCityName']?.toString() ?? '',
        isLicenseBased: json['isLicenseBased'] as bool? ?? false,
        entityType: json['entityType'] != null
            ? EntityTypeModel.fromJson(
                json['entityType'] as Map<String, dynamic>,
              )
            : EntityTypeModel(id: 0, name: '', characters: []),
        status: json['status'] != null
            ? StatusModel.fromJson(json['status'] as Map<String, dynamic>)
            : StatusModel(id: 0, name: ''),
        activities: json['activities'] != null
            ? (json['activities'] as List<dynamic>)
                  .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
                  .toList()
            : [],
      );
    } catch (e, stackTrace) {
      print('[CrInfoModel] Error parsing JSON: $e');
      print('[CrInfoModel] Stack trace: $stackTrace');
      print('[CrInfoModel] JSON keys: ${json.keys.toList()}');
      print('[CrInfoModel] JSON data: $json');
      rethrow;
    }
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
