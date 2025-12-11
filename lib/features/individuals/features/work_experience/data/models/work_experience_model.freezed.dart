// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_experience_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkExperienceModel {

 String get id;@JsonKey(name: 'job_title') String get jobTitle;@JsonKey(name: 'company_name') String get companyName;@JsonKey(name: 'employment_type') String get employmentType; String get location; List<String> get responsibilities;@JsonKey(name: 'start_date') DateTime get startDate;@JsonKey(name: 'end_date') DateTime? get endDate;@JsonKey(name: 'is_currently_working', defaultValue: false) bool get isCurrentlyWorking;
/// Create a copy of WorkExperienceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkExperienceModelCopyWith<WorkExperienceModel> get copyWith => _$WorkExperienceModelCopyWithImpl<WorkExperienceModel>(this as WorkExperienceModel, _$identity);

  /// Serializes this WorkExperienceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkExperienceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.responsibilities, responsibilities)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isCurrentlyWorking, isCurrentlyWorking) || other.isCurrentlyWorking == isCurrentlyWorking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobTitle,companyName,employmentType,location,const DeepCollectionEquality().hash(responsibilities),startDate,endDate,isCurrentlyWorking);

@override
String toString() {
  return 'WorkExperienceModel(id: $id, jobTitle: $jobTitle, companyName: $companyName, employmentType: $employmentType, location: $location, responsibilities: $responsibilities, startDate: $startDate, endDate: $endDate, isCurrentlyWorking: $isCurrentlyWorking)';
}


}

/// @nodoc
abstract mixin class $WorkExperienceModelCopyWith<$Res>  {
  factory $WorkExperienceModelCopyWith(WorkExperienceModel value, $Res Function(WorkExperienceModel) _then) = _$WorkExperienceModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'job_title') String jobTitle,@JsonKey(name: 'company_name') String companyName,@JsonKey(name: 'employment_type') String employmentType, String location, List<String> responsibilities,@JsonKey(name: 'start_date') DateTime startDate,@JsonKey(name: 'end_date') DateTime? endDate,@JsonKey(name: 'is_currently_working', defaultValue: false) bool isCurrentlyWorking
});




}
/// @nodoc
class _$WorkExperienceModelCopyWithImpl<$Res>
    implements $WorkExperienceModelCopyWith<$Res> {
  _$WorkExperienceModelCopyWithImpl(this._self, this._then);

  final WorkExperienceModel _self;
  final $Res Function(WorkExperienceModel) _then;

/// Create a copy of WorkExperienceModel
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


/// Adds pattern-matching-related methods to [WorkExperienceModel].
extension WorkExperienceModelPatterns on WorkExperienceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkExperienceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkExperienceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkExperienceModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkExperienceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkExperienceModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkExperienceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'job_title')  String jobTitle, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'employment_type')  String employmentType,  String location,  List<String> responsibilities, @JsonKey(name: 'start_date')  DateTime startDate, @JsonKey(name: 'end_date')  DateTime? endDate, @JsonKey(name: 'is_currently_working', defaultValue: false)  bool isCurrentlyWorking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkExperienceModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'job_title')  String jobTitle, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'employment_type')  String employmentType,  String location,  List<String> responsibilities, @JsonKey(name: 'start_date')  DateTime startDate, @JsonKey(name: 'end_date')  DateTime? endDate, @JsonKey(name: 'is_currently_working', defaultValue: false)  bool isCurrentlyWorking)  $default,) {final _that = this;
switch (_that) {
case _WorkExperienceModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'job_title')  String jobTitle, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'employment_type')  String employmentType,  String location,  List<String> responsibilities, @JsonKey(name: 'start_date')  DateTime startDate, @JsonKey(name: 'end_date')  DateTime? endDate, @JsonKey(name: 'is_currently_working', defaultValue: false)  bool isCurrentlyWorking)?  $default,) {final _that = this;
switch (_that) {
case _WorkExperienceModel() when $default != null:
return $default(_that.id,_that.jobTitle,_that.companyName,_that.employmentType,_that.location,_that.responsibilities,_that.startDate,_that.endDate,_that.isCurrentlyWorking);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkExperienceModel extends WorkExperienceModel {
  const _WorkExperienceModel({required this.id, @JsonKey(name: 'job_title') required this.jobTitle, @JsonKey(name: 'company_name') required this.companyName, @JsonKey(name: 'employment_type') required this.employmentType, required this.location, final  List<String> responsibilities = const [], @JsonKey(name: 'start_date') required this.startDate, @JsonKey(name: 'end_date') this.endDate, @JsonKey(name: 'is_currently_working', defaultValue: false) required this.isCurrentlyWorking}): _responsibilities = responsibilities,super._();
  factory _WorkExperienceModel.fromJson(Map<String, dynamic> json) => _$WorkExperienceModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'job_title') final  String jobTitle;
@override@JsonKey(name: 'company_name') final  String companyName;
@override@JsonKey(name: 'employment_type') final  String employmentType;
@override final  String location;
 final  List<String> _responsibilities;
@override@JsonKey() List<String> get responsibilities {
  if (_responsibilities is EqualUnmodifiableListView) return _responsibilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_responsibilities);
}

@override@JsonKey(name: 'start_date') final  DateTime startDate;
@override@JsonKey(name: 'end_date') final  DateTime? endDate;
@override@JsonKey(name: 'is_currently_working', defaultValue: false) final  bool isCurrentlyWorking;

/// Create a copy of WorkExperienceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkExperienceModelCopyWith<_WorkExperienceModel> get copyWith => __$WorkExperienceModelCopyWithImpl<_WorkExperienceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkExperienceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkExperienceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._responsibilities, _responsibilities)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isCurrentlyWorking, isCurrentlyWorking) || other.isCurrentlyWorking == isCurrentlyWorking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobTitle,companyName,employmentType,location,const DeepCollectionEquality().hash(_responsibilities),startDate,endDate,isCurrentlyWorking);

@override
String toString() {
  return 'WorkExperienceModel(id: $id, jobTitle: $jobTitle, companyName: $companyName, employmentType: $employmentType, location: $location, responsibilities: $responsibilities, startDate: $startDate, endDate: $endDate, isCurrentlyWorking: $isCurrentlyWorking)';
}


}

/// @nodoc
abstract mixin class _$WorkExperienceModelCopyWith<$Res> implements $WorkExperienceModelCopyWith<$Res> {
  factory _$WorkExperienceModelCopyWith(_WorkExperienceModel value, $Res Function(_WorkExperienceModel) _then) = __$WorkExperienceModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'job_title') String jobTitle,@JsonKey(name: 'company_name') String companyName,@JsonKey(name: 'employment_type') String employmentType, String location, List<String> responsibilities,@JsonKey(name: 'start_date') DateTime startDate,@JsonKey(name: 'end_date') DateTime? endDate,@JsonKey(name: 'is_currently_working', defaultValue: false) bool isCurrentlyWorking
});




}
/// @nodoc
class __$WorkExperienceModelCopyWithImpl<$Res>
    implements _$WorkExperienceModelCopyWith<$Res> {
  __$WorkExperienceModelCopyWithImpl(this._self, this._then);

  final _WorkExperienceModel _self;
  final $Res Function(_WorkExperienceModel) _then;

/// Create a copy of WorkExperienceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobTitle = null,Object? companyName = null,Object? employmentType = null,Object? location = null,Object? responsibilities = null,Object? startDate = null,Object? endDate = freezed,Object? isCurrentlyWorking = null,}) {
  return _then(_WorkExperienceModel(
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
