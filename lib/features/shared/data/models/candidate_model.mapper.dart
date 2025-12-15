// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'candidate_model.dart';

class CandidateModelMapper extends ClassMapperBase<CandidateModel> {
  CandidateModelMapper._();

  static CandidateModelMapper? _instance;
  static CandidateModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CandidateModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CandidateModel';

  static String? _$id(CandidateModel v) => v.id;
  static const Field<CandidateModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$candidateId(CandidateModel v) => v.candidateId;
  static const Field<CandidateModel, String> _f$candidateId = Field(
    'candidateId',
    _$candidateId,
    key: r'candidate_id',
    opt: true,
  );
  static Map<String, dynamic>? _$profiles(CandidateModel v) => v.profiles;
  static const Field<CandidateModel, Map<String, dynamic>> _f$profiles = Field(
    'profiles',
    _$profiles,
    opt: true,
  );
  static String? _$first_name(CandidateModel v) => v.first_name;
  static const Field<CandidateModel, String> _f$first_name = Field(
    'first_name',
    _$first_name,
    opt: true,
  );
  static String? _$last_name(CandidateModel v) => v.last_name;
  static const Field<CandidateModel, String> _f$last_name = Field(
    'last_name',
    _$last_name,
    opt: true,
  );
  static String? _$location(CandidateModel v) => v.location;
  static const Field<CandidateModel, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );
  static String? _$job_title(CandidateModel v) => v.job_title;
  static const Field<CandidateModel, String> _f$job_title = Field(
    'job_title',
    _$job_title,
    opt: true,
  );
  static dynamic _$skills(CandidateModel v) => v.skills;
  static const Field<CandidateModel, dynamic> _f$skills = Field(
    'skills',
    _$skills,
    opt: true,
  );
  static String? _$avatar_url(CandidateModel v) => v.avatar_url;
  static const Field<CandidateModel, String> _f$avatar_url = Field(
    'avatar_url',
    _$avatar_url,
    opt: true,
  );
  static bool? _$bookmarked(CandidateModel v) => v.bookmarked;
  static const Field<CandidateModel, bool> _f$bookmarked = Field(
    'bookmarked',
    _$bookmarked,
    opt: true,
  );

  @override
  final MappableFields<CandidateModel> fields = const {
    #id: _f$id,
    #candidateId: _f$candidateId,
    #profiles: _f$profiles,
    #first_name: _f$first_name,
    #last_name: _f$last_name,
    #location: _f$location,
    #job_title: _f$job_title,
    #skills: _f$skills,
    #avatar_url: _f$avatar_url,
    #bookmarked: _f$bookmarked,
  };

  static CandidateModel _instantiate(DecodingData data) {
    return CandidateModel(
      id: data.dec(_f$id),
      candidateId: data.dec(_f$candidateId),
      profiles: data.dec(_f$profiles),
      first_name: data.dec(_f$first_name),
      last_name: data.dec(_f$last_name),
      location: data.dec(_f$location),
      job_title: data.dec(_f$job_title),
      skills: data.dec(_f$skills),
      avatar_url: data.dec(_f$avatar_url),
      bookmarked: data.dec(_f$bookmarked),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CandidateModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CandidateModel>(map);
  }

  static CandidateModel fromJson(String json) {
    return ensureInitialized().decodeJson<CandidateModel>(json);
  }
}

mixin CandidateModelMappable {
  String toJson() {
    return CandidateModelMapper.ensureInitialized().encodeJson<CandidateModel>(
      this as CandidateModel,
    );
  }

  Map<String, dynamic> toMap() {
    return CandidateModelMapper.ensureInitialized().encodeMap<CandidateModel>(
      this as CandidateModel,
    );
  }

  CandidateModelCopyWith<CandidateModel, CandidateModel, CandidateModel>
  get copyWith => _CandidateModelCopyWithImpl<CandidateModel, CandidateModel>(
    this as CandidateModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return CandidateModelMapper.ensureInitialized().stringifyValue(
      this as CandidateModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CandidateModelMapper.ensureInitialized().equalsValue(
      this as CandidateModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CandidateModelMapper.ensureInitialized().hashValue(
      this as CandidateModel,
    );
  }
}

extension CandidateModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CandidateModel, $Out> {
  CandidateModelCopyWith<$R, CandidateModel, $Out> get $asCandidateModel =>
      $base.as((v, t, t2) => _CandidateModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CandidateModelCopyWith<$R, $In extends CandidateModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
  get profiles;
  $R call({
    String? id,
    String? candidateId,
    Map<String, dynamic>? profiles,
    String? first_name,
    String? last_name,
    String? location,
    String? job_title,
    dynamic skills,
    String? avatar_url,
    bool? bookmarked,
  });
  CandidateModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CandidateModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CandidateModel, $Out>
    implements CandidateModelCopyWith<$R, CandidateModel, $Out> {
  _CandidateModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CandidateModel> $mapper =
      CandidateModelMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
  get profiles => $value.profiles != null
      ? MapCopyWith(
          $value.profiles!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(profiles: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? candidateId = $none,
    Object? profiles = $none,
    Object? first_name = $none,
    Object? last_name = $none,
    Object? location = $none,
    Object? job_title = $none,
    Object? skills = $none,
    Object? avatar_url = $none,
    Object? bookmarked = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (candidateId != $none) #candidateId: candidateId,
      if (profiles != $none) #profiles: profiles,
      if (first_name != $none) #first_name: first_name,
      if (last_name != $none) #last_name: last_name,
      if (location != $none) #location: location,
      if (job_title != $none) #job_title: job_title,
      if (skills != $none) #skills: skills,
      if (avatar_url != $none) #avatar_url: avatar_url,
      if (bookmarked != $none) #bookmarked: bookmarked,
    }),
  );
  @override
  CandidateModel $make(CopyWithData data) => CandidateModel(
    id: data.get(#id, or: $value.id),
    candidateId: data.get(#candidateId, or: $value.candidateId),
    profiles: data.get(#profiles, or: $value.profiles),
    first_name: data.get(#first_name, or: $value.first_name),
    last_name: data.get(#last_name, or: $value.last_name),
    location: data.get(#location, or: $value.location),
    job_title: data.get(#job_title, or: $value.job_title),
    skills: data.get(#skills, or: $value.skills),
    avatar_url: data.get(#avatar_url, or: $value.avatar_url),
    bookmarked: data.get(#bookmarked, or: $value.bookmarked),
  );

  @override
  CandidateModelCopyWith<$R2, CandidateModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CandidateModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

