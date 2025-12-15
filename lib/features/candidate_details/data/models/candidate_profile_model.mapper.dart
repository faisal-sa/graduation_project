// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'candidate_profile_model.dart';

class CandidateProfileModelMapper
    extends ClassMapperBase<CandidateProfileModel> {
  CandidateProfileModelMapper._();

  static CandidateProfileModelMapper? _instance;
  static CandidateProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CandidateProfileModelMapper._());
      WorkExperienceModelMapper.ensureInitialized();
      EducationModelMapper.ensureInitialized();
      CertificationModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CandidateProfileModel';

  static String _$id(CandidateProfileModel v) => v.id;
  static const Field<CandidateProfileModel, String> _f$id = Field('id', _$id);
  static String _$firstName(CandidateProfileModel v) => v.firstName;
  static const Field<CandidateProfileModel, String> _f$firstName = Field(
    'firstName',
    _$firstName,
    key: r'first_name',
  );
  static String _$lastName(CandidateProfileModel v) => v.lastName;
  static const Field<CandidateProfileModel, String> _f$lastName = Field(
    'lastName',
    _$lastName,
    key: r'last_name',
  );
  static String _$jobTitle(CandidateProfileModel v) => v.jobTitle;
  static const Field<CandidateProfileModel, String> _f$jobTitle = Field(
    'jobTitle',
    _$jobTitle,
    key: r'job_title',
  );
  static String? _$aboutMe(CandidateProfileModel v) => v.aboutMe;
  static const Field<CandidateProfileModel, String> _f$aboutMe = Field(
    'aboutMe',
    _$aboutMe,
    key: r'about_me',
    opt: true,
  );
  static String? _$avatarUrl(CandidateProfileModel v) => v.avatarUrl;
  static const Field<CandidateProfileModel, String> _f$avatarUrl = Field(
    'avatarUrl',
    _$avatarUrl,
    key: r'avatar_url',
    opt: true,
  );
  static String? _$location(CandidateProfileModel v) => v.location;
  static const Field<CandidateProfileModel, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );
  static String? _$introVideoUrl(CandidateProfileModel v) => v.introVideoUrl;
  static const Field<CandidateProfileModel, String> _f$introVideoUrl = Field(
    'introVideoUrl',
    _$introVideoUrl,
    key: r'intro_video_url',
    opt: true,
  );
  static String? _$cvUrl(CandidateProfileModel v) => v.cvUrl;
  static const Field<CandidateProfileModel, String> _f$cvUrl = Field(
    'cvUrl',
    _$cvUrl,
    key: r'cv_url',
    opt: true,
  );
  static List<String> _$employmentTypes(CandidateProfileModel v) =>
      v.employmentTypes;
  static const Field<CandidateProfileModel, List<String>> _f$employmentTypes =
      Field(
        'employmentTypes',
        _$employmentTypes,
        key: r'employment_types',
        opt: true,
        def: const [],
      );
  static List<String> _$skills(CandidateProfileModel v) => v.skills;
  static const Field<CandidateProfileModel, List<String>> _f$skills = Field(
    'skills',
    _$skills,
  );
  static bool _$canRelocate(CandidateProfileModel v) => v.canRelocate;
  static const Field<CandidateProfileModel, bool> _f$canRelocate = Field(
    'canRelocate',
    _$canRelocate,
    key: r'can_relocate',
    opt: true,
    def: false,
  );
  static bool _$canStartImmediately(CandidateProfileModel v) =>
      v.canStartImmediately;
  static const Field<CandidateProfileModel, bool> _f$canStartImmediately =
      Field(
        'canStartImmediately',
        _$canStartImmediately,
        key: r'can_start_immediately',
        opt: true,
        def: false,
      );
  static List<String> _$languages(CandidateProfileModel v) => v.languages;
  static const Field<CandidateProfileModel, List<String>> _f$languages = Field(
    'languages',
    _$languages,
    opt: true,
    def: const [],
  );
  static List<String> _$targetRoles(CandidateProfileModel v) => v.targetRoles;
  static const Field<CandidateProfileModel, List<String>> _f$targetRoles =
      Field(
        'targetRoles',
        _$targetRoles,
        key: r'target_roles',
        opt: true,
        def: const [],
      );
  static int? _$minSalary(CandidateProfileModel v) => v.minSalary;
  static const Field<CandidateProfileModel, int> _f$minSalary = Field(
    'minSalary',
    _$minSalary,
    key: r'min_salary',
    opt: true,
  );
  static int? _$maxSalary(CandidateProfileModel v) => v.maxSalary;
  static const Field<CandidateProfileModel, int> _f$maxSalary = Field(
    'maxSalary',
    _$maxSalary,
    key: r'max_salary',
    opt: true,
  );
  static String? _$salaryCurrency(CandidateProfileModel v) => v.salaryCurrency;
  static const Field<CandidateProfileModel, String> _f$salaryCurrency = Field(
    'salaryCurrency',
    _$salaryCurrency,
    key: r'salary_currency',
    opt: true,
  );
  static String? _$currentWorkStatus(CandidateProfileModel v) =>
      v.currentWorkStatus;
  static const Field<CandidateProfileModel, String> _f$currentWorkStatus =
      Field(
        'currentWorkStatus',
        _$currentWorkStatus,
        key: r'current_work_status',
        opt: true,
      );
  static int? _$noticePeriodDays(CandidateProfileModel v) => v.noticePeriodDays;
  static const Field<CandidateProfileModel, int> _f$noticePeriodDays = Field(
    'noticePeriodDays',
    _$noticePeriodDays,
    key: r'notice_period_days',
    opt: true,
  );
  static List<String> _$workModes(CandidateProfileModel v) => v.workModes;
  static const Field<CandidateProfileModel, List<String>> _f$workModes = Field(
    'workModes',
    _$workModes,
    key: r'work_modes',
    opt: true,
    def: const [],
  );
  static String? _$email(CandidateProfileModel v) => v.email;
  static const Field<CandidateProfileModel, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
  );
  static String? _$phoneNumber(CandidateProfileModel v) => v.phoneNumber;
  static const Field<CandidateProfileModel, String> _f$phoneNumber = Field(
    'phoneNumber',
    _$phoneNumber,
    key: r'phone_number',
    opt: true,
  );
  static List<WorkExperienceModel> _$experiences(CandidateProfileModel v) =>
      v.experiences;
  static const Field<CandidateProfileModel, List<WorkExperienceModel>>
  _f$experiences = Field(
    'experiences',
    _$experiences,
    key: r'work_experiences',
  );
  static List<EducationModel> _$educations(CandidateProfileModel v) =>
      v.educations;
  static const Field<CandidateProfileModel, List<EducationModel>>
  _f$educations = Field('educations', _$educations);
  static List<CertificationModel> _$certifications(CandidateProfileModel v) =>
      v.certifications;
  static const Field<CandidateProfileModel, List<CertificationModel>>
  _f$certifications = Field('certifications', _$certifications);
  static bool _$isUnlocked(CandidateProfileModel v) => v.isUnlocked;
  static const Field<CandidateProfileModel, bool> _f$isUnlocked = Field(
    'isUnlocked',
    _$isUnlocked,
    key: r'is_unlocked',
  );
  static bool _$isBookmarked(CandidateProfileModel v) => v.isBookmarked;
  static const Field<CandidateProfileModel, bool> _f$isBookmarked = Field(
    'isBookmarked',
    _$isBookmarked,
    key: r'is_bookmarked',
    opt: true,
    def: false,
  );

  @override
  final MappableFields<CandidateProfileModel> fields = const {
    #id: _f$id,
    #firstName: _f$firstName,
    #lastName: _f$lastName,
    #jobTitle: _f$jobTitle,
    #aboutMe: _f$aboutMe,
    #avatarUrl: _f$avatarUrl,
    #location: _f$location,
    #introVideoUrl: _f$introVideoUrl,
    #cvUrl: _f$cvUrl,
    #employmentTypes: _f$employmentTypes,
    #skills: _f$skills,
    #canRelocate: _f$canRelocate,
    #canStartImmediately: _f$canStartImmediately,
    #languages: _f$languages,
    #targetRoles: _f$targetRoles,
    #minSalary: _f$minSalary,
    #maxSalary: _f$maxSalary,
    #salaryCurrency: _f$salaryCurrency,
    #currentWorkStatus: _f$currentWorkStatus,
    #noticePeriodDays: _f$noticePeriodDays,
    #workModes: _f$workModes,
    #email: _f$email,
    #phoneNumber: _f$phoneNumber,
    #experiences: _f$experiences,
    #educations: _f$educations,
    #certifications: _f$certifications,
    #isUnlocked: _f$isUnlocked,
    #isBookmarked: _f$isBookmarked,
  };

  static CandidateProfileModel _instantiate(DecodingData data) {
    return CandidateProfileModel(
      id: data.dec(_f$id),
      firstName: data.dec(_f$firstName),
      lastName: data.dec(_f$lastName),
      jobTitle: data.dec(_f$jobTitle),
      aboutMe: data.dec(_f$aboutMe),
      avatarUrl: data.dec(_f$avatarUrl),
      location: data.dec(_f$location),
      introVideoUrl: data.dec(_f$introVideoUrl),
      cvUrl: data.dec(_f$cvUrl),
      employmentTypes: data.dec(_f$employmentTypes),
      skills: data.dec(_f$skills),
      canRelocate: data.dec(_f$canRelocate),
      canStartImmediately: data.dec(_f$canStartImmediately),
      languages: data.dec(_f$languages),
      targetRoles: data.dec(_f$targetRoles),
      minSalary: data.dec(_f$minSalary),
      maxSalary: data.dec(_f$maxSalary),
      salaryCurrency: data.dec(_f$salaryCurrency),
      currentWorkStatus: data.dec(_f$currentWorkStatus),
      noticePeriodDays: data.dec(_f$noticePeriodDays),
      workModes: data.dec(_f$workModes),
      email: data.dec(_f$email),
      phoneNumber: data.dec(_f$phoneNumber),
      experiences: data.dec(_f$experiences),
      educations: data.dec(_f$educations),
      certifications: data.dec(_f$certifications),
      isUnlocked: data.dec(_f$isUnlocked),
      isBookmarked: data.dec(_f$isBookmarked),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CandidateProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CandidateProfileModel>(map);
  }

  static CandidateProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<CandidateProfileModel>(json);
  }
}

mixin CandidateProfileModelMappable {
  String toJson() {
    return CandidateProfileModelMapper.ensureInitialized()
        .encodeJson<CandidateProfileModel>(this as CandidateProfileModel);
  }

  Map<String, dynamic> toMap() {
    return CandidateProfileModelMapper.ensureInitialized()
        .encodeMap<CandidateProfileModel>(this as CandidateProfileModel);
  }

  @override
  String toString() {
    return CandidateProfileModelMapper.ensureInitialized().stringifyValue(
      this as CandidateProfileModel,
    );
  }
}

