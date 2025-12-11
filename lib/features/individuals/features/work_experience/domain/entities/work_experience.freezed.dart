// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_experience.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkExperience {

 String get id; String get jobTitle; String get companyName; String get employmentType; String get location; List<String> get responsibilities; DateTime get startDate; DateTime? get endDate; bool get isCurrentlyWorking;
/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkExperienceCopyWith<WorkExperience> get copyWith => _$WorkExperienceCopyWithImpl<WorkExperience>(this as WorkExperience, _$identity);

  /// Serializes this WorkExperience to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkExperience&&(identical(other.id, id) || other.id == id)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.responsibilities, responsibilities)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isCurrentlyWorking, isCurrentlyWorking) || other.isCurrentlyWorking == isCurrentlyWorking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobTitle,companyName,employmentType,location,const DeepCollectionEquality().hash(responsibilities),startDate,endDate,isCurrentlyWorking);

@override
String toString() {
  return 'WorkExperience(id: $id, jobTitle: $jobTitle, companyName: $companyName, employmentType: $employmentType, location: $location, responsibilities: $responsibilities, startDate: $startDate, endDate: $endDate, isCurrentlyWorking: $isCurrentlyWorking)';
}


}

/// @nodoc
abstract mixin class $WorkExperienceCopyWith<$Res>  {
  factory $WorkExperienceCopyWith(WorkExperience value, $Res Function(WorkExperience) _then) = _$WorkExperienceCopyWithImpl;
@useResult
$Res call({
 String id, String jobTitle, String companyName, String employmentType, String location, List<String> responsibilities, DateTime startDate, DateTime? endDate, bool isCurrentlyWorking
});




}
/// @nodoc
class _$WorkExperienceCopyWithImpl<$Res>
    implements $WorkExperienceCopyWith<$Res> {
  _$WorkExperienceCopyWithImpl(this._self, this._then);

  final WorkExperience _self;
  final $Res Function(WorkExperience) _then;

/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jobTitle = null,Object? companyName = null,Object? employmentType = null,Object? location = null,Object? responsibilities = null,Object? startDate = null,Object? endDate = freezed,Object? isCurrentlyWorking = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,employmentType: null == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,responsibilities: null == responsibilities ? _self.responsibilities : responsibilities // ignore: cast_nullable_to_non_nullable
as List<String>,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isCurrentlyWorking: null == isCurrentlyWorking ? _self.isCurrentlyWorking : isCurrentlyWorking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkExperience].
extension WorkExperiencePatterns on WorkExperience {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkExperience value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkExperience value)  $default,){
final _that = this;
switch (_that) {
case _WorkExperience():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkExperience value)?  $default,){
final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String jobTitle,  String companyName,  String employmentType,  String location,  List<String> responsibilities,  DateTime startDate,  DateTime? endDate,  bool isCurrentlyWorking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that.id,_that.jobTitle,_that.companyName,_that.employmentType,_that.location,_that.responsibilities,_that.startDate,_that.endDate,_that.isCurrentlyWorking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String jobTitle,  String companyName,  String employmentType,  String location,  List<String> responsibilities,  DateTime startDate,  DateTime? endDate,  bool isCurrentlyWorking)  $default,) {final _that = this;
switch (_that) {
case _WorkExperience():
return $default(_that.id,_that.jobTitle,_that.companyName,_that.employmentType,_that.location,_that.responsibilities,_that.startDate,_that.endDate,_that.isCurrentlyWorking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String jobTitle,  String companyName,  String employmentType,  String location,  List<String> responsibilities,  DateTime startDate,  DateTime? endDate,  bool isCurrentlyWorking)?  $default,) {final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that.id,_that.jobTitle,_that.companyName,_that.employmentType,_that.location,_that.responsibilities,_that.startDate,_that.endDate,_that.isCurrentlyWorking);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkExperience implements WorkExperience {
  const _WorkExperience({required this.id, this.jobTitle = '', this.companyName = '', this.employmentType = '', this.location = '', final  List<String> responsibilities = const [], required this.startDate, this.endDate, this.isCurrentlyWorking = false}): _responsibilities = responsibilities;
  factory _WorkExperience.fromJson(Map<String, dynamic> json) => _$WorkExperienceFromJson(json);

@override final  String id;
@override@JsonKey() final  String jobTitle;
@override@JsonKey() final  String companyName;
@override@JsonKey() final  String employmentType;
@override@JsonKey() final  String location;
 final  List<String> _responsibilities;
@override@JsonKey() List<String> get responsibilities {
  if (_responsibilities is EqualUnmodifiableListView) return _responsibilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_responsibilities);
}

@override final  DateTime startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool isCurrentlyWorking;

/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkExperienceCopyWith<_WorkExperience> get copyWith => __$WorkExperienceCopyWithImpl<_WorkExperience>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkExperienceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkExperience&&(identical(other.id, id) || other.id == id)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._responsibilities, _responsibilities)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isCurrentlyWorking, isCurrentlyWorking) || other.isCurrentlyWorking == isCurrentlyWorking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobTitle,companyName,employmentType,location,const DeepCollectionEquality().hash(_responsibilities),startDate,endDate,isCurrentlyWorking);

@override
String toString() {
  return 'WorkExperience(id: $id, jobTitle: $jobTitle, companyName: $companyName, employmentType: $employmentType, location: $location, responsibilities: $responsibilities, startDate: $startDate, endDate: $endDate, isCurrentlyWorking: $isCurrentlyWorking)';
}


}

/// @nodoc
abstract mixin class _$WorkExperienceCopyWith<$Res> implements $WorkExperienceCopyWith<$Res> {
  factory _$WorkExperienceCopyWith(_WorkExperience value, $Res Function(_WorkExperience) _then) = __$WorkExperienceCopyWithImpl;
@override @useResult
$Res call({
 String id, String jobTitle, String companyName, String employmentType, String location, List<String> responsibilities, DateTime startDate, DateTime? endDate, bool isCurrentlyWorking
});




}
/// @nodoc
class __$WorkExperienceCopyWithImpl<$Res>
    implements _$WorkExperienceCopyWith<$Res> {
  __$WorkExperienceCopyWithImpl(this._self, this._then);

  final _WorkExperience _self;
  final $Res Function(_WorkExperience) _then;

/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobTitle = null,Object? companyName = null,Object? employmentType = null,Object? location = null,Object? responsibilities = null,Object? startDate = null,Object? endDate = freezed,Object? isCurrentlyWorking = null,}) {
  return _then(_WorkExperience(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,employmentType: null == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,responsibilities: null == responsibilities ? _self._responsibilities : responsibilities // ignore: cast_nullable_to_non_nullable
as List<String>,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isCurrentlyWorking: null == isCurrentlyWorking ? _self.isCurrentlyWorking : isCurrentlyWorking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
