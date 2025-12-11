// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_preferences_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobPreferencesEntity {

 List<String> get targetRoles; int? get minSalary; int? get maxSalary; String? get salaryCurrency; String? get currentWorkStatus; List<String> get employmentTypes; List<String> get workModes; bool get canRelocate; bool get canStartImmediately; int? get noticePeriodDays;
/// Create a copy of JobPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobPreferencesEntityCopyWith<JobPreferencesEntity> get copyWith => _$JobPreferencesEntityCopyWithImpl<JobPreferencesEntity>(this as JobPreferencesEntity, _$identity);

  /// Serializes this JobPreferencesEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobPreferencesEntity&&const DeepCollectionEquality().equals(other.targetRoles, targetRoles)&&(identical(other.minSalary, minSalary) || other.minSalary == minSalary)&&(identical(other.maxSalary, maxSalary) || other.maxSalary == maxSalary)&&(identical(other.salaryCurrency, salaryCurrency) || other.salaryCurrency == salaryCurrency)&&(identical(other.currentWorkStatus, currentWorkStatus) || other.currentWorkStatus == currentWorkStatus)&&const DeepCollectionEquality().equals(other.employmentTypes, employmentTypes)&&const DeepCollectionEquality().equals(other.workModes, workModes)&&(identical(other.canRelocate, canRelocate) || other.canRelocate == canRelocate)&&(identical(other.canStartImmediately, canStartImmediately) || other.canStartImmediately == canStartImmediately)&&(identical(other.noticePeriodDays, noticePeriodDays) || other.noticePeriodDays == noticePeriodDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(targetRoles),minSalary,maxSalary,salaryCurrency,currentWorkStatus,const DeepCollectionEquality().hash(employmentTypes),const DeepCollectionEquality().hash(workModes),canRelocate,canStartImmediately,noticePeriodDays);

@override
String toString() {
  return 'JobPreferencesEntity(targetRoles: $targetRoles, minSalary: $minSalary, maxSalary: $maxSalary, salaryCurrency: $salaryCurrency, currentWorkStatus: $currentWorkStatus, employmentTypes: $employmentTypes, workModes: $workModes, canRelocate: $canRelocate, canStartImmediately: $canStartImmediately, noticePeriodDays: $noticePeriodDays)';
}


}

/// @nodoc
abstract mixin class $JobPreferencesEntityCopyWith<$Res>  {
  factory $JobPreferencesEntityCopyWith(JobPreferencesEntity value, $Res Function(JobPreferencesEntity) _then) = _$JobPreferencesEntityCopyWithImpl;
@useResult
$Res call({
 List<String> targetRoles, int? minSalary, int? maxSalary, String? salaryCurrency, String? currentWorkStatus, List<String> employmentTypes, List<String> workModes, bool canRelocate, bool canStartImmediately, int? noticePeriodDays
});




}
/// @nodoc
class _$JobPreferencesEntityCopyWithImpl<$Res>
    implements $JobPreferencesEntityCopyWith<$Res> {
  _$JobPreferencesEntityCopyWithImpl(this._self, this._then);

  final JobPreferencesEntity _self;
  final $Res Function(JobPreferencesEntity) _then;

/// Create a copy of JobPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetRoles = null,Object? minSalary = freezed,Object? maxSalary = freezed,Object? salaryCurrency = freezed,Object? currentWorkStatus = freezed,Object? employmentTypes = null,Object? workModes = null,Object? canRelocate = null,Object? canStartImmediately = null,Object? noticePeriodDays = freezed,}) {
  return _then(_self.copyWith(
targetRoles: null == targetRoles ? _self.targetRoles : targetRoles // ignore: cast_nullable_to_non_nullable
as List<String>,minSalary: freezed == minSalary ? _self.minSalary : minSalary // ignore: cast_nullable_to_non_nullable
as int?,maxSalary: freezed == maxSalary ? _self.maxSalary : maxSalary // ignore: cast_nullable_to_non_nullable
as int?,salaryCurrency: freezed == salaryCurrency ? _self.salaryCurrency : salaryCurrency // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [JobPreferencesEntity].
extension JobPreferencesEntityPatterns on JobPreferencesEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobPreferencesEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobPreferencesEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobPreferencesEntity value)  $default,){
final _that = this;
switch (_that) {
case _JobPreferencesEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobPreferencesEntity value)?  $default,){
final _that = this;
switch (_that) {
case _JobPreferencesEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> targetRoles,  int? minSalary,  int? maxSalary,  String? salaryCurrency,  String? currentWorkStatus,  List<String> employmentTypes,  List<String> workModes,  bool canRelocate,  bool canStartImmediately,  int? noticePeriodDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobPreferencesEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> targetRoles,  int? minSalary,  int? maxSalary,  String? salaryCurrency,  String? currentWorkStatus,  List<String> employmentTypes,  List<String> workModes,  bool canRelocate,  bool canStartImmediately,  int? noticePeriodDays)  $default,) {final _that = this;
switch (_that) {
case _JobPreferencesEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> targetRoles,  int? minSalary,  int? maxSalary,  String? salaryCurrency,  String? currentWorkStatus,  List<String> employmentTypes,  List<String> workModes,  bool canRelocate,  bool canStartImmediately,  int? noticePeriodDays)?  $default,) {final _that = this;
switch (_that) {
case _JobPreferencesEntity() when $default != null:
return $default(_that.targetRoles,_that.minSalary,_that.maxSalary,_that.salaryCurrency,_that.currentWorkStatus,_that.employmentTypes,_that.workModes,_that.canRelocate,_that.canStartImmediately,_that.noticePeriodDays);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _JobPreferencesEntity implements JobPreferencesEntity {
  const _JobPreferencesEntity({final  List<String> targetRoles = const [], this.minSalary, this.maxSalary, this.salaryCurrency = 'SAR', this.currentWorkStatus, final  List<String> employmentTypes = const [], final  List<String> workModes = const [], this.canRelocate = false, this.canStartImmediately = false, this.noticePeriodDays}): _targetRoles = targetRoles,_employmentTypes = employmentTypes,_workModes = workModes;
  factory _JobPreferencesEntity.fromJson(Map<String, dynamic> json) => _$JobPreferencesEntityFromJson(json);

 final  List<String> _targetRoles;
@override@JsonKey() List<String> get targetRoles {
  if (_targetRoles is EqualUnmodifiableListView) return _targetRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetRoles);
}

@override final  int? minSalary;
@override final  int? maxSalary;
@override@JsonKey() final  String? salaryCurrency;
@override final  String? currentWorkStatus;
 final  List<String> _employmentTypes;
@override@JsonKey() List<String> get employmentTypes {
  if (_employmentTypes is EqualUnmodifiableListView) return _employmentTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_employmentTypes);
}

 final  List<String> _workModes;
@override@JsonKey() List<String> get workModes {
  if (_workModes is EqualUnmodifiableListView) return _workModes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workModes);
}

@override@JsonKey() final  bool canRelocate;
@override@JsonKey() final  bool canStartImmediately;
@override final  int? noticePeriodDays;

/// Create a copy of JobPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobPreferencesEntityCopyWith<_JobPreferencesEntity> get copyWith => __$JobPreferencesEntityCopyWithImpl<_JobPreferencesEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobPreferencesEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobPreferencesEntity&&const DeepCollectionEquality().equals(other._targetRoles, _targetRoles)&&(identical(other.minSalary, minSalary) || other.minSalary == minSalary)&&(identical(other.maxSalary, maxSalary) || other.maxSalary == maxSalary)&&(identical(other.salaryCurrency, salaryCurrency) || other.salaryCurrency == salaryCurrency)&&(identical(other.currentWorkStatus, currentWorkStatus) || other.currentWorkStatus == currentWorkStatus)&&const DeepCollectionEquality().equals(other._employmentTypes, _employmentTypes)&&const DeepCollectionEquality().equals(other._workModes, _workModes)&&(identical(other.canRelocate, canRelocate) || other.canRelocate == canRelocate)&&(identical(other.canStartImmediately, canStartImmediately) || other.canStartImmediately == canStartImmediately)&&(identical(other.noticePeriodDays, noticePeriodDays) || other.noticePeriodDays == noticePeriodDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_targetRoles),minSalary,maxSalary,salaryCurrency,currentWorkStatus,const DeepCollectionEquality().hash(_employmentTypes),const DeepCollectionEquality().hash(_workModes),canRelocate,canStartImmediately,noticePeriodDays);

@override
String toString() {
  return 'JobPreferencesEntity(targetRoles: $targetRoles, minSalary: $minSalary, maxSalary: $maxSalary, salaryCurrency: $salaryCurrency, currentWorkStatus: $currentWorkStatus, employmentTypes: $employmentTypes, workModes: $workModes, canRelocate: $canRelocate, canStartImmediately: $canStartImmediately, noticePeriodDays: $noticePeriodDays)';
}


}

/// @nodoc
abstract mixin class _$JobPreferencesEntityCopyWith<$Res> implements $JobPreferencesEntityCopyWith<$Res> {
  factory _$JobPreferencesEntityCopyWith(_JobPreferencesEntity value, $Res Function(_JobPreferencesEntity) _then) = __$JobPreferencesEntityCopyWithImpl;
@override @useResult
$Res call({
 List<String> targetRoles, int? minSalary, int? maxSalary, String? salaryCurrency, String? currentWorkStatus, List<String> employmentTypes, List<String> workModes, bool canRelocate, bool canStartImmediately, int? noticePeriodDays
});




}
/// @nodoc
class __$JobPreferencesEntityCopyWithImpl<$Res>
    implements _$JobPreferencesEntityCopyWith<$Res> {
  __$JobPreferencesEntityCopyWithImpl(this._self, this._then);

  final _JobPreferencesEntity _self;
  final $Res Function(_JobPreferencesEntity) _then;

/// Create a copy of JobPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetRoles = null,Object? minSalary = freezed,Object? maxSalary = freezed,Object? salaryCurrency = freezed,Object? currentWorkStatus = freezed,Object? employmentTypes = null,Object? workModes = null,Object? canRelocate = null,Object? canStartImmediately = null,Object? noticePeriodDays = freezed,}) {
  return _then(_JobPreferencesEntity(
targetRoles: null == targetRoles ? _self._targetRoles : targetRoles // ignore: cast_nullable_to_non_nullable
as List<String>,minSalary: freezed == minSalary ? _self.minSalary : minSalary // ignore: cast_nullable_to_non_nullable
as int?,maxSalary: freezed == maxSalary ? _self.maxSalary : maxSalary // ignore: cast_nullable_to_non_nullable
as int?,salaryCurrency: freezed == salaryCurrency ? _self.salaryCurrency : salaryCurrency // ignore: cast_nullable_to_non_nullable
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
