// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_preferences_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobPreferencesModel {

@JsonKey(name: 'target_roles') List<String> get targetRoles;@JsonKey(name: 'min_salary') num? get minSalary;// Changed to num to allow int/double
@JsonKey(name: 'max_salary') num? get maxSalary;@JsonKey(name: 'salary_currency') String? get salaryCurrency;@JsonKey(name: 'current_work_status') String? get currentWorkStatus;@JsonKey(name: 'employment_types') List<String> get employmentTypes;@JsonKey(name: 'work_modes') List<String> get workModes;@JsonKey(name: 'can_relocate') bool get canRelocate;@JsonKey(name: 'can_start_immediately') bool get canStartImmediately;@JsonKey(name: 'notice_period_days') int? get noticePeriodDays;
/// Create a copy of JobPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobPreferencesModelCopyWith<JobPreferencesModel> get copyWith => _$JobPreferencesModelCopyWithImpl<JobPreferencesModel>(this as JobPreferencesModel, _$identity);

  /// Serializes this JobPreferencesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobPreferencesModel&&const DeepCollectionEquality().equals(other.targetRoles, targetRoles)&&(identical(other.minSalary, minSalary) || other.minSalary == minSalary)&&(identical(other.maxSalary, maxSalary) || other.maxSalary == maxSalary)&&(identical(other.salaryCurrency, salaryCurrency) || other.salaryCurrency == salaryCurrency)&&(identical(other.currentWorkStatus, currentWorkStatus) || other.currentWorkStatus == currentWorkStatus)&&const DeepCollectionEquality().equals(other.employmentTypes, employmentTypes)&&const DeepCollectionEquality().equals(other.workModes, workModes)&&(identical(other.canRelocate, canRelocate) || other.canRelocate == canRelocate)&&(identical(other.canStartImmediately, canStartImmediately) || other.canStartImmediately == canStartImmediately)&&(identical(other.noticePeriodDays, noticePeriodDays) || other.noticePeriodDays == noticePeriodDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(targetRoles),minSalary,maxSalary,salaryCurrency,currentWorkStatus,const DeepCollectionEquality().hash(employmentTypes),const DeepCollectionEquality().hash(workModes),canRelocate,canStartImmediately,noticePeriodDays);

@override
String toString() {
  return 'JobPreferencesModel(targetRoles: $targetRoles, minSalary: $minSalary, maxSalary: $maxSalary, salaryCurrency: $salaryCurrency, currentWorkStatus: $currentWorkStatus, employmentTypes: $employmentTypes, workModes: $workModes, canRelocate: $canRelocate, canStartImmediately: $canStartImmediately, noticePeriodDays: $noticePeriodDays)';
}


}

/// @nodoc
abstract mixin class $JobPreferencesModelCopyWith<$Res>  {
  factory $JobPreferencesModelCopyWith(JobPreferencesModel value, $Res Function(JobPreferencesModel) _then) = _$JobPreferencesModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'target_roles') List<String> targetRoles,@JsonKey(name: 'min_salary') num? minSalary,@JsonKey(name: 'max_salary') num? maxSalary,@JsonKey(name: 'salary_currency') String? salaryCurrency,@JsonKey(name: 'current_work_status') String? currentWorkStatus,@JsonKey(name: 'employment_types') List<String> employmentTypes,@JsonKey(name: 'work_modes') List<String> workModes,@JsonKey(name: 'can_relocate') bool canRelocate,@JsonKey(name: 'can_start_immediately') bool canStartImmediately,@JsonKey(name: 'notice_period_days') int? noticePeriodDays
});




}
/// @nodoc
class _$JobPreferencesModelCopyWithImpl<$Res>
    implements $JobPreferencesModelCopyWith<$Res> {
  _$JobPreferencesModelCopyWithImpl(this._self, this._then);

  final JobPreferencesModel _self;
  final $Res Function(JobPreferencesModel) _then;

/// Create a copy of JobPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetRoles = null,Object? minSalary = freezed,Object? maxSalary = freezed,Object? salaryCurrency = freezed,Object? currentWorkStatus = freezed,Object? employmentTypes = null,Object? workModes = null,Object? canRelocate = null,Object? canStartImmediately = null,Object? noticePeriodDays = freezed,}) {
  return _then(_self.copyWith(
targetRoles: null == targetRoles ? _self.targetRoles : targetRoles // ignore: cast_nullable_to_non_nullable
as List<String>,minSalary: freezed == minSalary ? _self.minSalary : minSalary // ignore: cast_nullable_to_non_nullable
as num?,maxSalary: freezed == maxSalary ? _self.maxSalary : maxSalary // ignore: cast_nullable_to_non_nullable
as num?,salaryCurrency: freezed == salaryCurrency ? _self.salaryCurrency : salaryCurrency // ignore: cast_nullable_to_non_nullable
as String?,currentWorkStatus: freezed == currentWorkStatus ? _self.currentWorkStatus : currentWorkStatus // ignore: cast_nullable_to_non_nullable
as String?,employmentTypes: null == employmentTypes ? _self.employmentTypes : employmentTypes // ignore: cast_nullable_to_non_nullable
as List<String>,workModes: null == workModes ? _self.workModes : workModes // ignore: cast_nullable_to_non_nullable
as List<String>,canRelocate: null == canRelocate ? _self.canRelocate : canRelocate // ignore: cast_nullable_to_non_nullable
as bool,canStartImmediately: null == canStartImmediately ? _self.canStartImmediately : canStartImmediately // ignore: cast_nullable_to_non_nullable
as bool,noticePeriodDays: freezed == noticePeriodDays ? _self.noticePeriodDays : noticePeriodDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobPreferencesModel].
extension JobPreferencesModelPatterns on JobPreferencesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobPreferencesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobPreferencesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobPreferencesModel value)  $default,){
final _that = this;
switch (_that) {
case _JobPreferencesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobPreferencesModel value)?  $default,){
final _that = this;
switch (_that) {
case _JobPreferencesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'target_roles')  List<String> targetRoles, @JsonKey(name: 'min_salary')  num? minSalary, @JsonKey(name: 'max_salary')  num? maxSalary, @JsonKey(name: 'salary_currency')  String? salaryCurrency, @JsonKey(name: 'current_work_status')  String? currentWorkStatus, @JsonKey(name: 'employment_types')  List<String> employmentTypes, @JsonKey(name: 'work_modes')  List<String> workModes, @JsonKey(name: 'can_relocate')  bool canRelocate, @JsonKey(name: 'can_start_immediately')  bool canStartImmediately, @JsonKey(name: 'notice_period_days')  int? noticePeriodDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobPreferencesModel() when $default != null:
return $default(_that.targetRoles,_that.minSalary,_that.maxSalary,_that.salaryCurrency,_that.currentWorkStatus,_that.employmentTypes,_that.workModes,_that.canRelocate,_that.canStartImmediately,_that.noticePeriodDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'target_roles')  List<String> targetRoles, @JsonKey(name: 'min_salary')  num? minSalary, @JsonKey(name: 'max_salary')  num? maxSalary, @JsonKey(name: 'salary_currency')  String? salaryCurrency, @JsonKey(name: 'current_work_status')  String? currentWorkStatus, @JsonKey(name: 'employment_types')  List<String> employmentTypes, @JsonKey(name: 'work_modes')  List<String> workModes, @JsonKey(name: 'can_relocate')  bool canRelocate, @JsonKey(name: 'can_start_immediately')  bool canStartImmediately, @JsonKey(name: 'notice_period_days')  int? noticePeriodDays)  $default,) {final _that = this;
switch (_that) {
case _JobPreferencesModel():
return $default(_that.targetRoles,_that.minSalary,_that.maxSalary,_that.salaryCurrency,_that.currentWorkStatus,_that.employmentTypes,_that.workModes,_that.canRelocate,_that.canStartImmediately,_that.noticePeriodDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'target_roles')  List<String> targetRoles, @JsonKey(name: 'min_salary')  num? minSalary, @JsonKey(name: 'max_salary')  num? maxSalary, @JsonKey(name: 'salary_currency')  String? salaryCurrency, @JsonKey(name: 'current_work_status')  String? currentWorkStatus, @JsonKey(name: 'employment_types')  List<String> employmentTypes, @JsonKey(name: 'work_modes')  List<String> workModes, @JsonKey(name: 'can_relocate')  bool canRelocate, @JsonKey(name: 'can_start_immediately')  bool canStartImmediately, @JsonKey(name: 'notice_period_days')  int? noticePeriodDays)?  $default,) {final _that = this;
switch (_that) {
case _JobPreferencesModel() when $default != null:
return $default(_that.targetRoles,_that.minSalary,_that.maxSalary,_that.salaryCurrency,_that.currentWorkStatus,_that.employmentTypes,_that.workModes,_that.canRelocate,_that.canStartImmediately,_that.noticePeriodDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobPreferencesModel extends JobPreferencesModel {
  const _JobPreferencesModel({@JsonKey(name: 'target_roles') final  List<String> targetRoles = const [], @JsonKey(name: 'min_salary') this.minSalary, @JsonKey(name: 'max_salary') this.maxSalary, @JsonKey(name: 'salary_currency') this.salaryCurrency, @JsonKey(name: 'current_work_status') this.currentWorkStatus, @JsonKey(name: 'employment_types') final  List<String> employmentTypes = const [], @JsonKey(name: 'work_modes') final  List<String> workModes = const [], @JsonKey(name: 'can_relocate') this.canRelocate = false, @JsonKey(name: 'can_start_immediately') this.canStartImmediately = false, @JsonKey(name: 'notice_period_days') this.noticePeriodDays}): _targetRoles = targetRoles,_employmentTypes = employmentTypes,_workModes = workModes,super._();
  factory _JobPreferencesModel.fromJson(Map<String, dynamic> json) => _$JobPreferencesModelFromJson(json);

 final  List<String> _targetRoles;
@override@JsonKey(name: 'target_roles') List<String> get targetRoles {
  if (_targetRoles is EqualUnmodifiableListView) return _targetRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetRoles);
}

@override@JsonKey(name: 'min_salary') final  num? minSalary;
// Changed to num to allow int/double
@override@JsonKey(name: 'max_salary') final  num? maxSalary;
@override@JsonKey(name: 'salary_currency') final  String? salaryCurrency;
@override@JsonKey(name: 'current_work_status') final  String? currentWorkStatus;
 final  List<String> _employmentTypes;
@override@JsonKey(name: 'employment_types') List<String> get employmentTypes {
  if (_employmentTypes is EqualUnmodifiableListView) return _employmentTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_employmentTypes);
}

 final  List<String> _workModes;
@override@JsonKey(name: 'work_modes') List<String> get workModes {
  if (_workModes is EqualUnmodifiableListView) return _workModes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workModes);
}

@override@JsonKey(name: 'can_relocate') final  bool canRelocate;
@override@JsonKey(name: 'can_start_immediately') final  bool canStartImmediately;
@override@JsonKey(name: 'notice_period_days') final  int? noticePeriodDays;

/// Create a copy of JobPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobPreferencesModelCopyWith<_JobPreferencesModel> get copyWith => __$JobPreferencesModelCopyWithImpl<_JobPreferencesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobPreferencesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobPreferencesModel&&const DeepCollectionEquality().equals(other._targetRoles, _targetRoles)&&(identical(other.minSalary, minSalary) || other.minSalary == minSalary)&&(identical(other.maxSalary, maxSalary) || other.maxSalary == maxSalary)&&(identical(other.salaryCurrency, salaryCurrency) || other.salaryCurrency == salaryCurrency)&&(identical(other.currentWorkStatus, currentWorkStatus) || other.currentWorkStatus == currentWorkStatus)&&const DeepCollectionEquality().equals(other._employmentTypes, _employmentTypes)&&const DeepCollectionEquality().equals(other._workModes, _workModes)&&(identical(other.canRelocate, canRelocate) || other.canRelocate == canRelocate)&&(identical(other.canStartImmediately, canStartImmediately) || other.canStartImmediately == canStartImmediately)&&(identical(other.noticePeriodDays, noticePeriodDays) || other.noticePeriodDays == noticePeriodDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_targetRoles),minSalary,maxSalary,salaryCurrency,currentWorkStatus,const DeepCollectionEquality().hash(_employmentTypes),const DeepCollectionEquality().hash(_workModes),canRelocate,canStartImmediately,noticePeriodDays);

@override
String toString() {
  return 'JobPreferencesModel(targetRoles: $targetRoles, minSalary: $minSalary, maxSalary: $maxSalary, salaryCurrency: $salaryCurrency, currentWorkStatus: $currentWorkStatus, employmentTypes: $employmentTypes, workModes: $workModes, canRelocate: $canRelocate, canStartImmediately: $canStartImmediately, noticePeriodDays: $noticePeriodDays)';
}


}

/// @nodoc
abstract mixin class _$JobPreferencesModelCopyWith<$Res> implements $JobPreferencesModelCopyWith<$Res> {
  factory _$JobPreferencesModelCopyWith(_JobPreferencesModel value, $Res Function(_JobPreferencesModel) _then) = __$JobPreferencesModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'target_roles') List<String> targetRoles,@JsonKey(name: 'min_salary') num? minSalary,@JsonKey(name: 'max_salary') num? maxSalary,@JsonKey(name: 'salary_currency') String? salaryCurrency,@JsonKey(name: 'current_work_status') String? currentWorkStatus,@JsonKey(name: 'employment_types') List<String> employmentTypes,@JsonKey(name: 'work_modes') List<String> workModes,@JsonKey(name: 'can_relocate') bool canRelocate,@JsonKey(name: 'can_start_immediately') bool canStartImmediately,@JsonKey(name: 'notice_period_days') int? noticePeriodDays
});




}
/// @nodoc
class __$JobPreferencesModelCopyWithImpl<$Res>
    implements _$JobPreferencesModelCopyWith<$Res> {
  __$JobPreferencesModelCopyWithImpl(this._self, this._then);

  final _JobPreferencesModel _self;
  final $Res Function(_JobPreferencesModel) _then;

/// Create a copy of JobPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetRoles = null,Object? minSalary = freezed,Object? maxSalary = freezed,Object? salaryCurrency = freezed,Object? currentWorkStatus = freezed,Object? employmentTypes = null,Object? workModes = null,Object? canRelocate = null,Object? canStartImmediately = null,Object? noticePeriodDays = freezed,}) {
  return _then(_JobPreferencesModel(
targetRoles: null == targetRoles ? _self._targetRoles : targetRoles // ignore: cast_nullable_to_non_nullable
as List<String>,minSalary: freezed == minSalary ? _self.minSalary : minSalary // ignore: cast_nullable_to_non_nullable
as num?,maxSalary: freezed == maxSalary ? _self.maxSalary : maxSalary // ignore: cast_nullable_to_non_nullable
as num?,salaryCurrency: freezed == salaryCurrency ? _self.salaryCurrency : salaryCurrency // ignore: cast_nullable_to_non_nullable
as String?,currentWorkStatus: freezed == currentWorkStatus ? _self.currentWorkStatus : currentWorkStatus // ignore: cast_nullable_to_non_nullable
as String?,employmentTypes: null == employmentTypes ? _self._employmentTypes : employmentTypes // ignore: cast_nullable_to_non_nullable
as List<String>,workModes: null == workModes ? _self._workModes : workModes // ignore: cast_nullable_to_non_nullable
as List<String>,canRelocate: null == canRelocate ? _self.canRelocate : canRelocate // ignore: cast_nullable_to_non_nullable
as bool,canStartImmediately: null == canStartImmediately ? _self.canStartImmediately : canStartImmediately // ignore: cast_nullable_to_non_nullable
as bool,noticePeriodDays: freezed == noticePeriodDays ? _self.noticePeriodDays : noticePeriodDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
