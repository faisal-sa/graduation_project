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
  static Map<String, dynamic>? _$candidates(CandidateModel v) => v.candidates;
  static const Field<CandidateModel, Map<String, dynamic>> _f$candidates =
      Field('candidates', _$candidates, opt: true);
  static String? _$full_name(CandidateModel v) => v.full_name;
  static const Field<CandidateModel, String> _f$full_name = Field(
    'full_name',
    _$full_name,
    opt: true,
  );
  static String? _$skills(CandidateModel v) => v.skills;
  static const Field<CandidateModel, String> _f$skills = Field(
    'skills',
    _$skills,
    opt: true,
  );
  static String? _$city(CandidateModel v) => v.city;
  static const Field<CandidateModel, String> _f$city = Field(
    'city',
    _$city,
    opt: true,
  );

  @override
  final MappableFields<CandidateModel> fields = const {
    #id: _f$id,
    #candidateId: _f$candidateId,
    #candidates: _f$candidates,
    #full_name: _f$full_name,
    #skills: _f$skills,
    #city: _f$city,
  };

  static CandidateModel _instantiate(DecodingData data) {
    return CandidateModel(
      id: data.dec(_f$id),
      candidateId: data.dec(_f$candidateId),
      candidates: data.dec(_f$candidates),
      full_name: data.dec(_f$full_name),
      skills: data.dec(_f$skills),
      city: data.dec(_f$city),
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
  get candidates;
  $R call({
    String? id,
    String? candidateId,
    Map<String, dynamic>? candidates,
    String? full_name,
    String? skills,
    String? city,
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
  get candidates => $value.candidates != null
      ? MapCopyWith(
          $value.candidates!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(candidates: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? candidateId = $none,
    Object? candidates = $none,
    Object? full_name = $none,
    Object? skills = $none,
    Object? city = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (candidateId != $none) #candidateId: candidateId,
      if (candidates != $none) #candidates: candidates,
      if (full_name != $none) #full_name: full_name,
      if (skills != $none) #skills: skills,
      if (city != $none) #city: city,
    }),
  );
  @override
  CandidateModel $make(CopyWithData data) => CandidateModel(
    id: data.get(#id, or: $value.id),
    candidateId: data.get(#candidateId, or: $value.candidateId),
    candidates: data.get(#candidates, or: $value.candidates),
    full_name: data.get(#full_name, or: $value.full_name),
    skills: data.get(#skills, or: $value.skills),
    city: data.get(#city, or: $value.city),
  );

  @override
  CandidateModelCopyWith<$R2, CandidateModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CandidateModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

