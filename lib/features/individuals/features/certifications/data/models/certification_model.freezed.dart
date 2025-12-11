// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CertificationModel {

 String get id; String get name;@JsonKey(name: 'issuing_institution') String get issuingInstitution;@JsonKey(name: 'issue_date') DateTime get issueDate;@JsonKey(name: 'expiration_date') DateTime? get expirationDate;@JsonKey(name: 'credential_url') String? get credentialUrl;// File/Local fields ignored in JSON
@JsonKey(includeFromJson: false, includeToJson: false) File? get credentialFile;// In your provided snippet, userId was a field in the model.
// If you want it part of the constructor but not the Entity interface:
@JsonKey(name: 'user_id') String get userId;
/// Create a copy of CertificationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CertificationModelCopyWith<CertificationModel> get copyWith => _$CertificationModelCopyWithImpl<CertificationModel>(this as CertificationModel, _$identity);

  /// Serializes this CertificationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CertificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.issuingInstitution, issuingInstitution) || other.issuingInstitution == issuingInstitution)&&(identical(other.issueDate, issueDate) || other.issueDate == issueDate)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.credentialUrl, credentialUrl) || other.credentialUrl == credentialUrl)&&(identical(other.credentialFile, credentialFile) || other.credentialFile == credentialFile)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,issuingInstitution,issueDate,expirationDate,credentialUrl,credentialFile,userId);

@override
String toString() {
  return 'CertificationModel(id: $id, name: $name, issuingInstitution: $issuingInstitution, issueDate: $issueDate, expirationDate: $expirationDate, credentialUrl: $credentialUrl, credentialFile: $credentialFile, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $CertificationModelCopyWith<$Res>  {
  factory $CertificationModelCopyWith(CertificationModel value, $Res Function(CertificationModel) _then) = _$CertificationModelCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'issuing_institution') String issuingInstitution,@JsonKey(name: 'issue_date') DateTime issueDate,@JsonKey(name: 'expiration_date') DateTime? expirationDate,@JsonKey(name: 'credential_url') String? credentialUrl,@JsonKey(includeFromJson: false, includeToJson: false) File? credentialFile,@JsonKey(name: 'user_id') String userId
});




}
/// @nodoc
class _$CertificationModelCopyWithImpl<$Res>
    implements $CertificationModelCopyWith<$Res> {
  _$CertificationModelCopyWithImpl(this._self, this._then);

  final CertificationModel _self;
  final $Res Function(CertificationModel) _then;

/// Create a copy of CertificationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? issuingInstitution = null,Object? issueDate = null,Object? expirationDate = freezed,Object? credentialUrl = freezed,Object? credentialFile = freezed,Object? userId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,issuingInstitution: null == issuingInstitution ? _self.issuingInstitution : issuingInstitution // ignore: cast_nullable_to_non_nullable
as String,issueDate: null == issueDate ? _self.issueDate : issueDate // ignore: cast_nullable_to_non_nullable
as DateTime,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,credentialUrl: freezed == credentialUrl ? _self.credentialUrl : credentialUrl // ignore: cast_nullable_to_non_nullable
as String?,credentialFile: freezed == credentialFile ? _self.credentialFile : credentialFile // ignore: cast_nullable_to_non_nullable
as File?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CertificationModel].
extension CertificationModelPatterns on CertificationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CertificationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CertificationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CertificationModel value)  $default,){
final _that = this;
switch (_that) {
case _CertificationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CertificationModel value)?  $default,){
final _that = this;
switch (_that) {
case _CertificationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'issuing_institution')  String issuingInstitution, @JsonKey(name: 'issue_date')  DateTime issueDate, @JsonKey(name: 'expiration_date')  DateTime? expirationDate, @JsonKey(name: 'credential_url')  String? credentialUrl, @JsonKey(includeFromJson: false, includeToJson: false)  File? credentialFile, @JsonKey(name: 'user_id')  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CertificationModel() when $default != null:
return $default(_that.id,_that.name,_that.issuingInstitution,_that.issueDate,_that.expirationDate,_that.credentialUrl,_that.credentialFile,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'issuing_institution')  String issuingInstitution, @JsonKey(name: 'issue_date')  DateTime issueDate, @JsonKey(name: 'expiration_date')  DateTime? expirationDate, @JsonKey(name: 'credential_url')  String? credentialUrl, @JsonKey(includeFromJson: false, includeToJson: false)  File? credentialFile, @JsonKey(name: 'user_id')  String userId)  $default,) {final _that = this;
switch (_that) {
case _CertificationModel():
return $default(_that.id,_that.name,_that.issuingInstitution,_that.issueDate,_that.expirationDate,_that.credentialUrl,_that.credentialFile,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'issuing_institution')  String issuingInstitution, @JsonKey(name: 'issue_date')  DateTime issueDate, @JsonKey(name: 'expiration_date')  DateTime? expirationDate, @JsonKey(name: 'credential_url')  String? credentialUrl, @JsonKey(includeFromJson: false, includeToJson: false)  File? credentialFile, @JsonKey(name: 'user_id')  String userId)?  $default,) {final _that = this;
switch (_that) {
case _CertificationModel() when $default != null:
return $default(_that.id,_that.name,_that.issuingInstitution,_that.issueDate,_that.expirationDate,_that.credentialUrl,_that.credentialFile,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CertificationModel extends CertificationModel {
  const _CertificationModel({required this.id, required this.name, @JsonKey(name: 'issuing_institution') required this.issuingInstitution, @JsonKey(name: 'issue_date') required this.issueDate, @JsonKey(name: 'expiration_date') this.expirationDate, @JsonKey(name: 'credential_url') this.credentialUrl, @JsonKey(includeFromJson: false, includeToJson: false) this.credentialFile, @JsonKey(name: 'user_id') required this.userId}): super._();
  factory _CertificationModel.fromJson(Map<String, dynamic> json) => _$CertificationModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'issuing_institution') final  String issuingInstitution;
@override@JsonKey(name: 'issue_date') final  DateTime issueDate;
@override@JsonKey(name: 'expiration_date') final  DateTime? expirationDate;
@override@JsonKey(name: 'credential_url') final  String? credentialUrl;
// File/Local fields ignored in JSON
@override@JsonKey(includeFromJson: false, includeToJson: false) final  File? credentialFile;
// In your provided snippet, userId was a field in the model.
// If you want it part of the constructor but not the Entity interface:
@override@JsonKey(name: 'user_id') final  String userId;

/// Create a copy of CertificationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CertificationModelCopyWith<_CertificationModel> get copyWith => __$CertificationModelCopyWithImpl<_CertificationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CertificationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CertificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.issuingInstitution, issuingInstitution) || other.issuingInstitution == issuingInstitution)&&(identical(other.issueDate, issueDate) || other.issueDate == issueDate)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.credentialUrl, credentialUrl) || other.credentialUrl == credentialUrl)&&(identical(other.credentialFile, credentialFile) || other.credentialFile == credentialFile)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,issuingInstitution,issueDate,expirationDate,credentialUrl,credentialFile,userId);

@override
String toString() {
  return 'CertificationModel(id: $id, name: $name, issuingInstitution: $issuingInstitution, issueDate: $issueDate, expirationDate: $expirationDate, credentialUrl: $credentialUrl, credentialFile: $credentialFile, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$CertificationModelCopyWith<$Res> implements $CertificationModelCopyWith<$Res> {
  factory _$CertificationModelCopyWith(_CertificationModel value, $Res Function(_CertificationModel) _then) = __$CertificationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'issuing_institution') String issuingInstitution,@JsonKey(name: 'issue_date') DateTime issueDate,@JsonKey(name: 'expiration_date') DateTime? expirationDate,@JsonKey(name: 'credential_url') String? credentialUrl,@JsonKey(includeFromJson: false, includeToJson: false) File? credentialFile,@JsonKey(name: 'user_id') String userId
});




}
/// @nodoc
class __$CertificationModelCopyWithImpl<$Res>
    implements _$CertificationModelCopyWith<$Res> {
  __$CertificationModelCopyWithImpl(this._self, this._then);

  final _CertificationModel _self;
  final $Res Function(_CertificationModel) _then;

/// Create a copy of CertificationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? issuingInstitution = null,Object? issueDate = null,Object? expirationDate = freezed,Object? credentialUrl = freezed,Object? credentialFile = freezed,Object? userId = null,}) {
  return _then(_CertificationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,issuingInstitution: null == issuingInstitution ? _self.issuingInstitution : issuingInstitution // ignore: cast_nullable_to_non_nullable
as String,issueDate: null == issueDate ? _self.issueDate : issueDate // ignore: cast_nullable_to_non_nullable
as DateTime,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,credentialUrl: freezed == credentialUrl ? _self.credentialUrl : credentialUrl // ignore: cast_nullable_to_non_nullable
as String?,credentialFile: freezed == credentialFile ? _self.credentialFile : credentialFile // ignore: cast_nullable_to_non_nullable
as File?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
