// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'education_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EducationModel {

 String get id;@JsonKey(name: 'degree_type') String get degreeType;@JsonKey(name: 'institution_name') String get institutionName;@JsonKey(name: 'field_of_study') String get fieldOfStudy;@JsonKey(name: 'start_date') DateTime get startDate;@JsonKey(name: 'end_date') DateTime get endDate; String? get gpa; List<String> get activities;@JsonKey(name: 'graduation_certificate_url') String? get graduationCertificateUrl;@JsonKey(name: 'academic_record_url') String? get academicRecordUrl;@JsonKey(includeFromJson: false, includeToJson: false) dynamic get graduationCertificateBytes;@JsonKey(includeFromJson: false, includeToJson: false) String? get graduationCertificateName;@JsonKey(includeFromJson: false, includeToJson: false) dynamic get academicRecordBytes;@JsonKey(includeFromJson: false, includeToJson: false) String? get academicRecordName;
/// Create a copy of EducationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EducationModelCopyWith<EducationModel> get copyWith => _$EducationModelCopyWithImpl<EducationModel>(this as EducationModel, _$identity);

  /// Serializes this EducationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EducationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.degreeType, degreeType) || other.degreeType == degreeType)&&(identical(other.institutionName, institutionName) || other.institutionName == institutionName)&&(identical(other.fieldOfStudy, fieldOfStudy) || other.fieldOfStudy == fieldOfStudy)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&const DeepCollectionEquality().equals(other.activities, activities)&&(identical(other.graduationCertificateUrl, graduationCertificateUrl) || other.graduationCertificateUrl == graduationCertificateUrl)&&(identical(other.academicRecordUrl, academicRecordUrl) || other.academicRecordUrl == academicRecordUrl)&&const DeepCollectionEquality().equals(other.graduationCertificateBytes, graduationCertificateBytes)&&(identical(other.graduationCertificateName, graduationCertificateName) || other.graduationCertificateName == graduationCertificateName)&&const DeepCollectionEquality().equals(other.academicRecordBytes, academicRecordBytes)&&(identical(other.academicRecordName, academicRecordName) || other.academicRecordName == academicRecordName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,degreeType,institutionName,fieldOfStudy,startDate,endDate,gpa,const DeepCollectionEquality().hash(activities),graduationCertificateUrl,academicRecordUrl,const DeepCollectionEquality().hash(graduationCertificateBytes),graduationCertificateName,const DeepCollectionEquality().hash(academicRecordBytes),academicRecordName);

@override
String toString() {
  return 'EducationModel(id: $id, degreeType: $degreeType, institutionName: $institutionName, fieldOfStudy: $fieldOfStudy, startDate: $startDate, endDate: $endDate, gpa: $gpa, activities: $activities, graduationCertificateUrl: $graduationCertificateUrl, academicRecordUrl: $academicRecordUrl, graduationCertificateBytes: $graduationCertificateBytes, graduationCertificateName: $graduationCertificateName, academicRecordBytes: $academicRecordBytes, academicRecordName: $academicRecordName)';
}


}

/// @nodoc
abstract mixin class $EducationModelCopyWith<$Res>  {
  factory $EducationModelCopyWith(EducationModel value, $Res Function(EducationModel) _then) = _$EducationModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'degree_type') String degreeType,@JsonKey(name: 'institution_name') String institutionName,@JsonKey(name: 'field_of_study') String fieldOfStudy,@JsonKey(name: 'start_date') DateTime startDate,@JsonKey(name: 'end_date') DateTime endDate, String? gpa, List<String> activities,@JsonKey(name: 'graduation_certificate_url') String? graduationCertificateUrl,@JsonKey(name: 'academic_record_url') String? academicRecordUrl,@JsonKey(includeFromJson: false, includeToJson: false) dynamic graduationCertificateBytes,@JsonKey(includeFromJson: false, includeToJson: false) String? graduationCertificateName,@JsonKey(includeFromJson: false, includeToJson: false) dynamic academicRecordBytes,@JsonKey(includeFromJson: false, includeToJson: false) String? academicRecordName
});




}
/// @nodoc
class _$EducationModelCopyWithImpl<$Res>
    implements $EducationModelCopyWith<$Res> {
  _$EducationModelCopyWithImpl(this._self, this._then);

  final EducationModel _self;
  final $Res Function(EducationModel) _then;

/// Create a copy of EducationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? degreeType = null,Object? institutionName = null,Object? fieldOfStudy = null,Object? startDate = null,Object? endDate = null,Object? gpa = freezed,Object? activities = null,Object? graduationCertificateUrl = freezed,Object? academicRecordUrl = freezed,Object? graduationCertificateBytes = freezed,Object? graduationCertificateName = freezed,Object? academicRecordBytes = freezed,Object? academicRecordName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,degreeType: null == degreeType ? _self.degreeType : degreeType // ignore: cast_nullable_to_non_nullable
as String,institutionName: null == institutionName ? _self.institutionName : institutionName // ignore: cast_nullable_to_non_nullable
as String,fieldOfStudy: null == fieldOfStudy ? _self.fieldOfStudy : fieldOfStudy // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as String?,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<String>,graduationCertificateUrl: freezed == graduationCertificateUrl ? _self.graduationCertificateUrl : graduationCertificateUrl // ignore: cast_nullable_to_non_nullable
as String?,academicRecordUrl: freezed == academicRecordUrl ? _self.academicRecordUrl : academicRecordUrl // ignore: cast_nullable_to_non_nullable
as String?,graduationCertificateBytes: freezed == graduationCertificateBytes ? _self.graduationCertificateBytes : graduationCertificateBytes // ignore: cast_nullable_to_non_nullable
as dynamic,graduationCertificateName: freezed == graduationCertificateName ? _self.graduationCertificateName : graduationCertificateName // ignore: cast_nullable_to_non_nullable
as String?,academicRecordBytes: freezed == academicRecordBytes ? _self.academicRecordBytes : academicRecordBytes // ignore: cast_nullable_to_non_nullable
as dynamic,academicRecordName: freezed == academicRecordName ? _self.academicRecordName : academicRecordName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EducationModel].
extension EducationModelPatterns on EducationModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EducationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EducationModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EducationModel value)  $default,){
final _that = this;
switch (_that) {
case _EducationModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EducationModel value)?  $default,){
final _that = this;
switch (_that) {
case _EducationModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'degree_type')  String degreeType, @JsonKey(name: 'institution_name')  String institutionName, @JsonKey(name: 'field_of_study')  String fieldOfStudy, @JsonKey(name: 'start_date')  DateTime startDate, @JsonKey(name: 'end_date')  DateTime endDate,  String? gpa,  List<String> activities, @JsonKey(name: 'graduation_certificate_url')  String? graduationCertificateUrl, @JsonKey(name: 'academic_record_url')  String? academicRecordUrl, @JsonKey(includeFromJson: false, includeToJson: false)  dynamic graduationCertificateBytes, @JsonKey(includeFromJson: false, includeToJson: false)  String? graduationCertificateName, @JsonKey(includeFromJson: false, includeToJson: false)  dynamic academicRecordBytes, @JsonKey(includeFromJson: false, includeToJson: false)  String? academicRecordName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EducationModel() when $default != null:
return $default(_that.id,_that.degreeType,_that.institutionName,_that.fieldOfStudy,_that.startDate,_that.endDate,_that.gpa,_that.activities,_that.graduationCertificateUrl,_that.academicRecordUrl,_that.graduationCertificateBytes,_that.graduationCertificateName,_that.academicRecordBytes,_that.academicRecordName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'degree_type')  String degreeType, @JsonKey(name: 'institution_name')  String institutionName, @JsonKey(name: 'field_of_study')  String fieldOfStudy, @JsonKey(name: 'start_date')  DateTime startDate, @JsonKey(name: 'end_date')  DateTime endDate,  String? gpa,  List<String> activities, @JsonKey(name: 'graduation_certificate_url')  String? graduationCertificateUrl, @JsonKey(name: 'academic_record_url')  String? academicRecordUrl, @JsonKey(includeFromJson: false, includeToJson: false)  dynamic graduationCertificateBytes, @JsonKey(includeFromJson: false, includeToJson: false)  String? graduationCertificateName, @JsonKey(includeFromJson: false, includeToJson: false)  dynamic academicRecordBytes, @JsonKey(includeFromJson: false, includeToJson: false)  String? academicRecordName)  $default,) {final _that = this;
switch (_that) {
case _EducationModel():
return $default(_that.id,_that.degreeType,_that.institutionName,_that.fieldOfStudy,_that.startDate,_that.endDate,_that.gpa,_that.activities,_that.graduationCertificateUrl,_that.academicRecordUrl,_that.graduationCertificateBytes,_that.graduationCertificateName,_that.academicRecordBytes,_that.academicRecordName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'degree_type')  String degreeType, @JsonKey(name: 'institution_name')  String institutionName, @JsonKey(name: 'field_of_study')  String fieldOfStudy, @JsonKey(name: 'start_date')  DateTime startDate, @JsonKey(name: 'end_date')  DateTime endDate,  String? gpa,  List<String> activities, @JsonKey(name: 'graduation_certificate_url')  String? graduationCertificateUrl, @JsonKey(name: 'academic_record_url')  String? academicRecordUrl, @JsonKey(includeFromJson: false, includeToJson: false)  dynamic graduationCertificateBytes, @JsonKey(includeFromJson: false, includeToJson: false)  String? graduationCertificateName, @JsonKey(includeFromJson: false, includeToJson: false)  dynamic academicRecordBytes, @JsonKey(includeFromJson: false, includeToJson: false)  String? academicRecordName)?  $default,) {final _that = this;
switch (_that) {
case _EducationModel() when $default != null:
return $default(_that.id,_that.degreeType,_that.institutionName,_that.fieldOfStudy,_that.startDate,_that.endDate,_that.gpa,_that.activities,_that.graduationCertificateUrl,_that.academicRecordUrl,_that.graduationCertificateBytes,_that.graduationCertificateName,_that.academicRecordBytes,_that.academicRecordName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EducationModel extends EducationModel {
  const _EducationModel({required this.id, @JsonKey(name: 'degree_type') required this.degreeType, @JsonKey(name: 'institution_name') required this.institutionName, @JsonKey(name: 'field_of_study') required this.fieldOfStudy, @JsonKey(name: 'start_date') required this.startDate, @JsonKey(name: 'end_date') required this.endDate, this.gpa, final  List<String> activities = const [], @JsonKey(name: 'graduation_certificate_url') this.graduationCertificateUrl, @JsonKey(name: 'academic_record_url') this.academicRecordUrl, @JsonKey(includeFromJson: false, includeToJson: false) this.graduationCertificateBytes, @JsonKey(includeFromJson: false, includeToJson: false) this.graduationCertificateName, @JsonKey(includeFromJson: false, includeToJson: false) this.academicRecordBytes, @JsonKey(includeFromJson: false, includeToJson: false) this.academicRecordName}): _activities = activities,super._();
  factory _EducationModel.fromJson(Map<String, dynamic> json) => _$EducationModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'degree_type') final  String degreeType;
@override@JsonKey(name: 'institution_name') final  String institutionName;
@override@JsonKey(name: 'field_of_study') final  String fieldOfStudy;
@override@JsonKey(name: 'start_date') final  DateTime startDate;
@override@JsonKey(name: 'end_date') final  DateTime endDate;
@override final  String? gpa;
 final  List<String> _activities;
@override@JsonKey() List<String> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}

@override@JsonKey(name: 'graduation_certificate_url') final  String? graduationCertificateUrl;
@override@JsonKey(name: 'academic_record_url') final  String? academicRecordUrl;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  dynamic graduationCertificateBytes;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? graduationCertificateName;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  dynamic academicRecordBytes;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? academicRecordName;

/// Create a copy of EducationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EducationModelCopyWith<_EducationModel> get copyWith => __$EducationModelCopyWithImpl<_EducationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EducationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EducationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.degreeType, degreeType) || other.degreeType == degreeType)&&(identical(other.institutionName, institutionName) || other.institutionName == institutionName)&&(identical(other.fieldOfStudy, fieldOfStudy) || other.fieldOfStudy == fieldOfStudy)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&const DeepCollectionEquality().equals(other._activities, _activities)&&(identical(other.graduationCertificateUrl, graduationCertificateUrl) || other.graduationCertificateUrl == graduationCertificateUrl)&&(identical(other.academicRecordUrl, academicRecordUrl) || other.academicRecordUrl == academicRecordUrl)&&const DeepCollectionEquality().equals(other.graduationCertificateBytes, graduationCertificateBytes)&&(identical(other.graduationCertificateName, graduationCertificateName) || other.graduationCertificateName == graduationCertificateName)&&const DeepCollectionEquality().equals(other.academicRecordBytes, academicRecordBytes)&&(identical(other.academicRecordName, academicRecordName) || other.academicRecordName == academicRecordName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,degreeType,institutionName,fieldOfStudy,startDate,endDate,gpa,const DeepCollectionEquality().hash(_activities),graduationCertificateUrl,academicRecordUrl,const DeepCollectionEquality().hash(graduationCertificateBytes),graduationCertificateName,const DeepCollectionEquality().hash(academicRecordBytes),academicRecordName);

@override
String toString() {
  return 'EducationModel(id: $id, degreeType: $degreeType, institutionName: $institutionName, fieldOfStudy: $fieldOfStudy, startDate: $startDate, endDate: $endDate, gpa: $gpa, activities: $activities, graduationCertificateUrl: $graduationCertificateUrl, academicRecordUrl: $academicRecordUrl, graduationCertificateBytes: $graduationCertificateBytes, graduationCertificateName: $graduationCertificateName, academicRecordBytes: $academicRecordBytes, academicRecordName: $academicRecordName)';
}


}

/// @nodoc
abstract mixin class _$EducationModelCopyWith<$Res> implements $EducationModelCopyWith<$Res> {
  factory _$EducationModelCopyWith(_EducationModel value, $Res Function(_EducationModel) _then) = __$EducationModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'degree_type') String degreeType,@JsonKey(name: 'institution_name') String institutionName,@JsonKey(name: 'field_of_study') String fieldOfStudy,@JsonKey(name: 'start_date') DateTime startDate,@JsonKey(name: 'end_date') DateTime endDate, String? gpa, List<String> activities,@JsonKey(name: 'graduation_certificate_url') String? graduationCertificateUrl,@JsonKey(name: 'academic_record_url') String? academicRecordUrl,@JsonKey(includeFromJson: false, includeToJson: false) dynamic graduationCertificateBytes,@JsonKey(includeFromJson: false, includeToJson: false) String? graduationCertificateName,@JsonKey(includeFromJson: false, includeToJson: false) dynamic academicRecordBytes,@JsonKey(includeFromJson: false, includeToJson: false) String? academicRecordName
});




}
/// @nodoc
class __$EducationModelCopyWithImpl<$Res>
    implements _$EducationModelCopyWith<$Res> {
  __$EducationModelCopyWithImpl(this._self, this._then);

  final _EducationModel _self;
  final $Res Function(_EducationModel) _then;

/// Create a copy of EducationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? degreeType = null,Object? institutionName = null,Object? fieldOfStudy = null,Object? startDate = null,Object? endDate = null,Object? gpa = freezed,Object? activities = null,Object? graduationCertificateUrl = freezed,Object? academicRecordUrl = freezed,Object? graduationCertificateBytes = freezed,Object? graduationCertificateName = freezed,Object? academicRecordBytes = freezed,Object? academicRecordName = freezed,}) {
  return _then(_EducationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,degreeType: null == degreeType ? _self.degreeType : degreeType // ignore: cast_nullable_to_non_nullable
as String,institutionName: null == institutionName ? _self.institutionName : institutionName // ignore: cast_nullable_to_non_nullable
as String,fieldOfStudy: null == fieldOfStudy ? _self.fieldOfStudy : fieldOfStudy // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as String?,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<String>,graduationCertificateUrl: freezed == graduationCertificateUrl ? _self.graduationCertificateUrl : graduationCertificateUrl // ignore: cast_nullable_to_non_nullable
as String?,academicRecordUrl: freezed == academicRecordUrl ? _self.academicRecordUrl : academicRecordUrl // ignore: cast_nullable_to_non_nullable
as String?,graduationCertificateBytes: freezed == graduationCertificateBytes ? _self.graduationCertificateBytes : graduationCertificateBytes // ignore: cast_nullable_to_non_nullable
as dynamic,graduationCertificateName: freezed == graduationCertificateName ? _self.graduationCertificateName : graduationCertificateName // ignore: cast_nullable_to_non_nullable
as String?,academicRecordBytes: freezed == academicRecordBytes ? _self.academicRecordBytes : academicRecordBytes // ignore: cast_nullable_to_non_nullable
as dynamic,academicRecordName: freezed == academicRecordName ? _self.academicRecordName : academicRecordName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
