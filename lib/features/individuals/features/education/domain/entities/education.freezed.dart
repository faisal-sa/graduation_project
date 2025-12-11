// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'education.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Education {

 String get id; String get degreeType; String get institutionName; String get fieldOfStudy; DateTime get startDate; DateTime get endDate; String? get gpa; List<String> get activities;// Custom converter for Base64 <-> Uint8List
@Uint8ListConverter() Uint8List? get graduationCertificateBytes; String? get graduationCertificateName;@Uint8ListConverter() Uint8List? get academicRecordBytes; String? get academicRecordName; String? get graduationCertificateUrl; String? get academicRecordUrl;
/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EducationCopyWith<Education> get copyWith => _$EducationCopyWithImpl<Education>(this as Education, _$identity);

  /// Serializes this Education to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Education&&(identical(other.id, id) || other.id == id)&&(identical(other.degreeType, degreeType) || other.degreeType == degreeType)&&(identical(other.institutionName, institutionName) || other.institutionName == institutionName)&&(identical(other.fieldOfStudy, fieldOfStudy) || other.fieldOfStudy == fieldOfStudy)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&const DeepCollectionEquality().equals(other.activities, activities)&&const DeepCollectionEquality().equals(other.graduationCertificateBytes, graduationCertificateBytes)&&(identical(other.graduationCertificateName, graduationCertificateName) || other.graduationCertificateName == graduationCertificateName)&&const DeepCollectionEquality().equals(other.academicRecordBytes, academicRecordBytes)&&(identical(other.academicRecordName, academicRecordName) || other.academicRecordName == academicRecordName)&&(identical(other.graduationCertificateUrl, graduationCertificateUrl) || other.graduationCertificateUrl == graduationCertificateUrl)&&(identical(other.academicRecordUrl, academicRecordUrl) || other.academicRecordUrl == academicRecordUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,degreeType,institutionName,fieldOfStudy,startDate,endDate,gpa,const DeepCollectionEquality().hash(activities),const DeepCollectionEquality().hash(graduationCertificateBytes),graduationCertificateName,const DeepCollectionEquality().hash(academicRecordBytes),academicRecordName,graduationCertificateUrl,academicRecordUrl);

@override
String toString() {
  return 'Education(id: $id, degreeType: $degreeType, institutionName: $institutionName, fieldOfStudy: $fieldOfStudy, startDate: $startDate, endDate: $endDate, gpa: $gpa, activities: $activities, graduationCertificateBytes: $graduationCertificateBytes, graduationCertificateName: $graduationCertificateName, academicRecordBytes: $academicRecordBytes, academicRecordName: $academicRecordName, graduationCertificateUrl: $graduationCertificateUrl, academicRecordUrl: $academicRecordUrl)';
}


}

/// @nodoc
abstract mixin class $EducationCopyWith<$Res>  {
  factory $EducationCopyWith(Education value, $Res Function(Education) _then) = _$EducationCopyWithImpl;
@useResult
$Res call({
 String id, String degreeType, String institutionName, String fieldOfStudy, DateTime startDate, DateTime endDate, String? gpa, List<String> activities,@Uint8ListConverter() Uint8List? graduationCertificateBytes, String? graduationCertificateName,@Uint8ListConverter() Uint8List? academicRecordBytes, String? academicRecordName, String? graduationCertificateUrl, String? academicRecordUrl
});




}
/// @nodoc
class _$EducationCopyWithImpl<$Res>
    implements $EducationCopyWith<$Res> {
  _$EducationCopyWithImpl(this._self, this._then);

  final Education _self;
  final $Res Function(Education) _then;

/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? degreeType = null,Object? institutionName = null,Object? fieldOfStudy = null,Object? startDate = null,Object? endDate = null,Object? gpa = freezed,Object? activities = null,Object? graduationCertificateBytes = freezed,Object? graduationCertificateName = freezed,Object? academicRecordBytes = freezed,Object? academicRecordName = freezed,Object? graduationCertificateUrl = freezed,Object? academicRecordUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,degreeType: null == degreeType ? _self.degreeType : degreeType // ignore: cast_nullable_to_non_nullable
as String,institutionName: null == institutionName ? _self.institutionName : institutionName // ignore: cast_nullable_to_non_nullable
as String,fieldOfStudy: null == fieldOfStudy ? _self.fieldOfStudy : fieldOfStudy // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as String?,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<String>,graduationCertificateBytes: freezed == graduationCertificateBytes ? _self.graduationCertificateBytes : graduationCertificateBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,graduationCertificateName: freezed == graduationCertificateName ? _self.graduationCertificateName : graduationCertificateName // ignore: cast_nullable_to_non_nullable
as String?,academicRecordBytes: freezed == academicRecordBytes ? _self.academicRecordBytes : academicRecordBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,academicRecordName: freezed == academicRecordName ? _self.academicRecordName : academicRecordName // ignore: cast_nullable_to_non_nullable
as String?,graduationCertificateUrl: freezed == graduationCertificateUrl ? _self.graduationCertificateUrl : graduationCertificateUrl // ignore: cast_nullable_to_non_nullable
as String?,academicRecordUrl: freezed == academicRecordUrl ? _self.academicRecordUrl : academicRecordUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Education].
extension EducationPatterns on Education {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Education value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Education() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Education value)  $default,){
final _that = this;
switch (_that) {
case _Education():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Education value)?  $default,){
final _that = this;
switch (_that) {
case _Education() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String degreeType,  String institutionName,  String fieldOfStudy,  DateTime startDate,  DateTime endDate,  String? gpa,  List<String> activities, @Uint8ListConverter()  Uint8List? graduationCertificateBytes,  String? graduationCertificateName, @Uint8ListConverter()  Uint8List? academicRecordBytes,  String? academicRecordName,  String? graduationCertificateUrl,  String? academicRecordUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.id,_that.degreeType,_that.institutionName,_that.fieldOfStudy,_that.startDate,_that.endDate,_that.gpa,_that.activities,_that.graduationCertificateBytes,_that.graduationCertificateName,_that.academicRecordBytes,_that.academicRecordName,_that.graduationCertificateUrl,_that.academicRecordUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String degreeType,  String institutionName,  String fieldOfStudy,  DateTime startDate,  DateTime endDate,  String? gpa,  List<String> activities, @Uint8ListConverter()  Uint8List? graduationCertificateBytes,  String? graduationCertificateName, @Uint8ListConverter()  Uint8List? academicRecordBytes,  String? academicRecordName,  String? graduationCertificateUrl,  String? academicRecordUrl)  $default,) {final _that = this;
switch (_that) {
case _Education():
return $default(_that.id,_that.degreeType,_that.institutionName,_that.fieldOfStudy,_that.startDate,_that.endDate,_that.gpa,_that.activities,_that.graduationCertificateBytes,_that.graduationCertificateName,_that.academicRecordBytes,_that.academicRecordName,_that.graduationCertificateUrl,_that.academicRecordUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String degreeType,  String institutionName,  String fieldOfStudy,  DateTime startDate,  DateTime endDate,  String? gpa,  List<String> activities, @Uint8ListConverter()  Uint8List? graduationCertificateBytes,  String? graduationCertificateName, @Uint8ListConverter()  Uint8List? academicRecordBytes,  String? academicRecordName,  String? graduationCertificateUrl,  String? academicRecordUrl)?  $default,) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.id,_that.degreeType,_that.institutionName,_that.fieldOfStudy,_that.startDate,_that.endDate,_that.gpa,_that.activities,_that.graduationCertificateBytes,_that.graduationCertificateName,_that.academicRecordBytes,_that.academicRecordName,_that.graduationCertificateUrl,_that.academicRecordUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Education implements Education {
  const _Education({required this.id, this.degreeType = '', this.institutionName = '', this.fieldOfStudy = '', required this.startDate, required this.endDate, this.gpa, final  List<String> activities = const [], @Uint8ListConverter() this.graduationCertificateBytes, this.graduationCertificateName, @Uint8ListConverter() this.academicRecordBytes, this.academicRecordName, this.graduationCertificateUrl, this.academicRecordUrl}): _activities = activities;
  factory _Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);

@override final  String id;
@override@JsonKey() final  String degreeType;
@override@JsonKey() final  String institutionName;
@override@JsonKey() final  String fieldOfStudy;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  String? gpa;
 final  List<String> _activities;
@override@JsonKey() List<String> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}

// Custom converter for Base64 <-> Uint8List
@override@Uint8ListConverter() final  Uint8List? graduationCertificateBytes;
@override final  String? graduationCertificateName;
@override@Uint8ListConverter() final  Uint8List? academicRecordBytes;
@override final  String? academicRecordName;
@override final  String? graduationCertificateUrl;
@override final  String? academicRecordUrl;

/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EducationCopyWith<_Education> get copyWith => __$EducationCopyWithImpl<_Education>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EducationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Education&&(identical(other.id, id) || other.id == id)&&(identical(other.degreeType, degreeType) || other.degreeType == degreeType)&&(identical(other.institutionName, institutionName) || other.institutionName == institutionName)&&(identical(other.fieldOfStudy, fieldOfStudy) || other.fieldOfStudy == fieldOfStudy)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&const DeepCollectionEquality().equals(other._activities, _activities)&&const DeepCollectionEquality().equals(other.graduationCertificateBytes, graduationCertificateBytes)&&(identical(other.graduationCertificateName, graduationCertificateName) || other.graduationCertificateName == graduationCertificateName)&&const DeepCollectionEquality().equals(other.academicRecordBytes, academicRecordBytes)&&(identical(other.academicRecordName, academicRecordName) || other.academicRecordName == academicRecordName)&&(identical(other.graduationCertificateUrl, graduationCertificateUrl) || other.graduationCertificateUrl == graduationCertificateUrl)&&(identical(other.academicRecordUrl, academicRecordUrl) || other.academicRecordUrl == academicRecordUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,degreeType,institutionName,fieldOfStudy,startDate,endDate,gpa,const DeepCollectionEquality().hash(_activities),const DeepCollectionEquality().hash(graduationCertificateBytes),graduationCertificateName,const DeepCollectionEquality().hash(academicRecordBytes),academicRecordName,graduationCertificateUrl,academicRecordUrl);

@override
String toString() {
  return 'Education(id: $id, degreeType: $degreeType, institutionName: $institutionName, fieldOfStudy: $fieldOfStudy, startDate: $startDate, endDate: $endDate, gpa: $gpa, activities: $activities, graduationCertificateBytes: $graduationCertificateBytes, graduationCertificateName: $graduationCertificateName, academicRecordBytes: $academicRecordBytes, academicRecordName: $academicRecordName, graduationCertificateUrl: $graduationCertificateUrl, academicRecordUrl: $academicRecordUrl)';
}


}

/// @nodoc
abstract mixin class _$EducationCopyWith<$Res> implements $EducationCopyWith<$Res> {
  factory _$EducationCopyWith(_Education value, $Res Function(_Education) _then) = __$EducationCopyWithImpl;
@override @useResult
$Res call({
 String id, String degreeType, String institutionName, String fieldOfStudy, DateTime startDate, DateTime endDate, String? gpa, List<String> activities,@Uint8ListConverter() Uint8List? graduationCertificateBytes, String? graduationCertificateName,@Uint8ListConverter() Uint8List? academicRecordBytes, String? academicRecordName, String? graduationCertificateUrl, String? academicRecordUrl
});




}
/// @nodoc
class __$EducationCopyWithImpl<$Res>
    implements _$EducationCopyWith<$Res> {
  __$EducationCopyWithImpl(this._self, this._then);

  final _Education _self;
  final $Res Function(_Education) _then;

/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? degreeType = null,Object? institutionName = null,Object? fieldOfStudy = null,Object? startDate = null,Object? endDate = null,Object? gpa = freezed,Object? activities = null,Object? graduationCertificateBytes = freezed,Object? graduationCertificateName = freezed,Object? academicRecordBytes = freezed,Object? academicRecordName = freezed,Object? graduationCertificateUrl = freezed,Object? academicRecordUrl = freezed,}) {
  return _then(_Education(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,degreeType: null == degreeType ? _self.degreeType : degreeType // ignore: cast_nullable_to_non_nullable
as String,institutionName: null == institutionName ? _self.institutionName : institutionName // ignore: cast_nullable_to_non_nullable
as String,fieldOfStudy: null == fieldOfStudy ? _self.fieldOfStudy : fieldOfStudy // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as String?,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<String>,graduationCertificateBytes: freezed == graduationCertificateBytes ? _self.graduationCertificateBytes : graduationCertificateBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,graduationCertificateName: freezed == graduationCertificateName ? _self.graduationCertificateName : graduationCertificateName // ignore: cast_nullable_to_non_nullable
as String?,academicRecordBytes: freezed == academicRecordBytes ? _self.academicRecordBytes : academicRecordBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,academicRecordName: freezed == academicRecordName ? _self.academicRecordName : academicRecordName // ignore: cast_nullable_to_non_nullable
as String?,graduationCertificateUrl: freezed == graduationCertificateUrl ? _self.graduationCertificateUrl : graduationCertificateUrl // ignore: cast_nullable_to_non_nullable
as String?,academicRecordUrl: freezed == academicRecordUrl ? _self.academicRecordUrl : academicRecordUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
