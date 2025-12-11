// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserEntity {

 String get firstName; String get lastName; String get jobTitle; String get phoneNumber; String get email; String get location;// Ensure all keys match DB columns or use @JsonKey
@JsonKey(name: 'about_me') String get summary;@JsonKey(name: 'intro_video_url') String? get videoUrl;// Explicitly map if DB is different
 String? get avatarUrl;// Children lists (handled automatically if DB returns nested arrays)
 List<WorkExperience> get workExperiences; List<Education> get educations; List<Certification> get certifications; List<String> get skills; List<String> get languages;// THE MAGIC FIX:
// 1. readValue: _readRoot passes the entire DB response to JobPreferencesEntity
// 2. JobPreferencesEntity extracts 'min_salary', etc. from that root map
@JsonKey(readValue: _readRoot) JobPreferencesEntity get jobPreferences;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);

  /// Serializes this UserEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.location, location) || other.location == location)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&const DeepCollectionEquality().equals(other.workExperiences, workExperiences)&&const DeepCollectionEquality().equals(other.educations, educations)&&const DeepCollectionEquality().equals(other.certifications, certifications)&&const DeepCollectionEquality().equals(other.skills, skills)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.jobPreferences, jobPreferences) || other.jobPreferences == jobPreferences));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,jobTitle,phoneNumber,email,location,summary,videoUrl,avatarUrl,const DeepCollectionEquality().hash(workExperiences),const DeepCollectionEquality().hash(educations),const DeepCollectionEquality().hash(certifications),const DeepCollectionEquality().hash(skills),const DeepCollectionEquality().hash(languages),jobPreferences);

@override
String toString() {
  return 'UserEntity(firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, phoneNumber: $phoneNumber, email: $email, location: $location, summary: $summary, videoUrl: $videoUrl, avatarUrl: $avatarUrl, workExperiences: $workExperiences, educations: $educations, certifications: $certifications, skills: $skills, languages: $languages, jobPreferences: $jobPreferences)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String jobTitle, String phoneNumber, String email, String location,@JsonKey(name: 'about_me') String summary,@JsonKey(name: 'intro_video_url') String? videoUrl, String? avatarUrl, List<WorkExperience> workExperiences, List<Education> educations, List<Certification> certifications, List<String> skills, List<String> languages,@JsonKey(readValue: _readRoot) JobPreferencesEntity jobPreferences
});


$JobPreferencesEntityCopyWith<$Res> get jobPreferences;

}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? jobTitle = null,Object? phoneNumber = null,Object? email = null,Object? location = null,Object? summary = null,Object? videoUrl = freezed,Object? avatarUrl = freezed,Object? workExperiences = null,Object? educations = null,Object? certifications = null,Object? skills = null,Object? languages = null,Object? jobPreferences = null,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,workExperiences: null == workExperiences ? _self.workExperiences : workExperiences // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,educations: null == educations ? _self.educations : educations // ignore: cast_nullable_to_non_nullable
as List<Education>,certifications: null == certifications ? _self.certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<Certification>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,jobPreferences: null == jobPreferences ? _self.jobPreferences : jobPreferences // ignore: cast_nullable_to_non_nullable
as JobPreferencesEntity,
  ));
}
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobPreferencesEntityCopyWith<$Res> get jobPreferences {
  
  return $JobPreferencesEntityCopyWith<$Res>(_self.jobPreferences, (value) {
    return _then(_self.copyWith(jobPreferences: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserEntity].
extension UserEntityPatterns on UserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String jobTitle,  String phoneNumber,  String email,  String location, @JsonKey(name: 'about_me')  String summary, @JsonKey(name: 'intro_video_url')  String? videoUrl,  String? avatarUrl,  List<WorkExperience> workExperiences,  List<Education> educations,  List<Certification> certifications,  List<String> skills,  List<String> languages, @JsonKey(readValue: _readRoot)  JobPreferencesEntity jobPreferences)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.firstName,_that.lastName,_that.jobTitle,_that.phoneNumber,_that.email,_that.location,_that.summary,_that.videoUrl,_that.avatarUrl,_that.workExperiences,_that.educations,_that.certifications,_that.skills,_that.languages,_that.jobPreferences);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String jobTitle,  String phoneNumber,  String email,  String location, @JsonKey(name: 'about_me')  String summary, @JsonKey(name: 'intro_video_url')  String? videoUrl,  String? avatarUrl,  List<WorkExperience> workExperiences,  List<Education> educations,  List<Certification> certifications,  List<String> skills,  List<String> languages, @JsonKey(readValue: _readRoot)  JobPreferencesEntity jobPreferences)  $default,) {final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that.firstName,_that.lastName,_that.jobTitle,_that.phoneNumber,_that.email,_that.location,_that.summary,_that.videoUrl,_that.avatarUrl,_that.workExperiences,_that.educations,_that.certifications,_that.skills,_that.languages,_that.jobPreferences);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String jobTitle,  String phoneNumber,  String email,  String location, @JsonKey(name: 'about_me')  String summary, @JsonKey(name: 'intro_video_url')  String? videoUrl,  String? avatarUrl,  List<WorkExperience> workExperiences,  List<Education> educations,  List<Certification> certifications,  List<String> skills,  List<String> languages, @JsonKey(readValue: _readRoot)  JobPreferencesEntity jobPreferences)?  $default,) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.firstName,_that.lastName,_that.jobTitle,_that.phoneNumber,_that.email,_that.location,_that.summary,_that.videoUrl,_that.avatarUrl,_that.workExperiences,_that.educations,_that.certifications,_that.skills,_that.languages,_that.jobPreferences);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _UserEntity implements UserEntity {
  const _UserEntity({this.firstName = '', this.lastName = '', this.jobTitle = '', this.phoneNumber = '', this.email = '', this.location = '', @JsonKey(name: 'about_me') this.summary = '', @JsonKey(name: 'intro_video_url') this.videoUrl, this.avatarUrl, final  List<WorkExperience> workExperiences = const [], final  List<Education> educations = const [], final  List<Certification> certifications = const [], final  List<String> skills = const [], final  List<String> languages = const [], @JsonKey(readValue: _readRoot) this.jobPreferences = const JobPreferencesEntity()}): _workExperiences = workExperiences,_educations = educations,_certifications = certifications,_skills = skills,_languages = languages;
  factory _UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  String jobTitle;
@override@JsonKey() final  String phoneNumber;
@override@JsonKey() final  String email;
@override@JsonKey() final  String location;
// Ensure all keys match DB columns or use @JsonKey
@override@JsonKey(name: 'about_me') final  String summary;
@override@JsonKey(name: 'intro_video_url') final  String? videoUrl;
// Explicitly map if DB is different
@override final  String? avatarUrl;
// Children lists (handled automatically if DB returns nested arrays)
 final  List<WorkExperience> _workExperiences;
// Children lists (handled automatically if DB returns nested arrays)
@override@JsonKey() List<WorkExperience> get workExperiences {
  if (_workExperiences is EqualUnmodifiableListView) return _workExperiences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workExperiences);
}

 final  List<Education> _educations;
@override@JsonKey() List<Education> get educations {
  if (_educations is EqualUnmodifiableListView) return _educations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_educations);
}

 final  List<Certification> _certifications;
@override@JsonKey() List<Certification> get certifications {
  if (_certifications is EqualUnmodifiableListView) return _certifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_certifications);
}

 final  List<String> _skills;
@override@JsonKey() List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

// THE MAGIC FIX:
// 1. readValue: _readRoot passes the entire DB response to JobPreferencesEntity
// 2. JobPreferencesEntity extracts 'min_salary', etc. from that root map
@override@JsonKey(readValue: _readRoot) final  JobPreferencesEntity jobPreferences;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntityCopyWith<_UserEntity> get copyWith => __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntity&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.location, location) || other.location == location)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&const DeepCollectionEquality().equals(other._workExperiences, _workExperiences)&&const DeepCollectionEquality().equals(other._educations, _educations)&&const DeepCollectionEquality().equals(other._certifications, _certifications)&&const DeepCollectionEquality().equals(other._skills, _skills)&&const DeepCollectionEquality().equals(other._languages, _languages)&&(identical(other.jobPreferences, jobPreferences) || other.jobPreferences == jobPreferences));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,jobTitle,phoneNumber,email,location,summary,videoUrl,avatarUrl,const DeepCollectionEquality().hash(_workExperiences),const DeepCollectionEquality().hash(_educations),const DeepCollectionEquality().hash(_certifications),const DeepCollectionEquality().hash(_skills),const DeepCollectionEquality().hash(_languages),jobPreferences);

@override
String toString() {
  return 'UserEntity(firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, phoneNumber: $phoneNumber, email: $email, location: $location, summary: $summary, videoUrl: $videoUrl, avatarUrl: $avatarUrl, workExperiences: $workExperiences, educations: $educations, certifications: $certifications, skills: $skills, languages: $languages, jobPreferences: $jobPreferences)';
}


}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(_UserEntity value, $Res Function(_UserEntity) _then) = __$UserEntityCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String jobTitle, String phoneNumber, String email, String location,@JsonKey(name: 'about_me') String summary,@JsonKey(name: 'intro_video_url') String? videoUrl, String? avatarUrl, List<WorkExperience> workExperiences, List<Education> educations, List<Certification> certifications, List<String> skills, List<String> languages,@JsonKey(readValue: _readRoot) JobPreferencesEntity jobPreferences
});


@override $JobPreferencesEntityCopyWith<$Res> get jobPreferences;

}
/// @nodoc
class __$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? jobTitle = null,Object? phoneNumber = null,Object? email = null,Object? location = null,Object? summary = null,Object? videoUrl = freezed,Object? avatarUrl = freezed,Object? workExperiences = null,Object? educations = null,Object? certifications = null,Object? skills = null,Object? languages = null,Object? jobPreferences = null,}) {
  return _then(_UserEntity(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,workExperiences: null == workExperiences ? _self._workExperiences : workExperiences // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,educations: null == educations ? _self._educations : educations // ignore: cast_nullable_to_non_nullable
as List<Education>,certifications: null == certifications ? _self._certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<Certification>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,jobPreferences: null == jobPreferences ? _self.jobPreferences : jobPreferences // ignore: cast_nullable_to_non_nullable
as JobPreferencesEntity,
  ));
}

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobPreferencesEntityCopyWith<$Res> get jobPreferences {
  
  return $JobPreferencesEntityCopyWith<$Res>(_self.jobPreferences, (value) {
    return _then(_self.copyWith(jobPreferences: value));
  });
}
}

// dart format on
