// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Certification {

 String get id; String get name; String get issuingInstitution; DateTime get issueDate; DateTime? get expirationDate; String? get credentialUrl;@JsonKey(includeFromJson: false, includeToJson: false) File? get credentialFile;
/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CertificationCopyWith<Certification> get copyWith => _$CertificationCopyWithImpl<Certification>(this as Certification, _$identity);

  /// Serializes this Certification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Certification&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.issuingInstitution, issuingInstitution) || other.issuingInstitution == issuingInstitution)&&(identical(other.issueDate, issueDate) || other.issueDate == issueDate)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.credentialUrl, credentialUrl) || other.credentialUrl == credentialUrl)&&(identical(other.credentialFile, credentialFile) || other.credentialFile == credentialFile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,issuingInstitution,issueDate,expirationDate,credentialUrl,credentialFile);

@override
String toString() {
  return 'Certification(id: $id, name: $name, issuingInstitution: $issuingInstitution, issueDate: $issueDate, expirationDate: $expirationDate, credentialUrl: $credentialUrl, credentialFile: $credentialFile)';
}


}

/// @nodoc
abstract mixin class $CertificationCopyWith<$Res>  {
  factory $CertificationCopyWith(Certification value, $Res Function(Certification) _then) = _$CertificationCopyWithImpl;
@useResult
$Res call({
 String id, String name, String issuingInstitution, DateTime issueDate, DateTime? expirationDate, String? credentialUrl,@JsonKey(includeFromJson: false, includeToJson: false) File? credentialFile
});




}
/// @nodoc
class _$CertificationCopyWithImpl<$Res>
    implements $CertificationCopyWith<$Res> {
  _$CertificationCopyWithImpl(this._self, this._then);

  final Certification _self;
  final $Res Function(Certification) _then;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? issuingInstitution = null,Object? issueDate = null,Object? expirationDate = freezed,Object? credentialUrl = freezed,Object? credentialFile = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,issuingInstitution: null == issuingInstitution ? _self.issuingInstitution : issuingInstitution // ignore: cast_nullable_to_non_nullable
as String,issueDate: null == issueDate ? _self.issueDate : issueDate // ignore: cast_nullable_to_non_nullable
as DateTime,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,credentialUrl: freezed == credentialUrl ? _self.credentialUrl : credentialUrl // ignore: cast_nullable_to_non_nullable
as String?,credentialFile: freezed == credentialFile ? _self.credentialFile : credentialFile // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}

}


/// Adds pattern-matching-related methods to [Certification].
extension CertificationPatterns on Certification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Certification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Certification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Certification value)  $default,){
final _that = this;
switch (_that) {
case _Certification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Certification value)?  $default,){
final _that = this;
switch (_that) {
case _Certification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String issuingInstitution,  DateTime issueDate,  DateTime? expirationDate,  String? credentialUrl, @JsonKey(includeFromJson: false, includeToJson: false)  File? credentialFile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Certification() when $default != null:
return $default(_that.id,_that.name,_that.issuingInstitution,_that.issueDate,_that.expirationDate,_that.credentialUrl,_that.credentialFile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String issuingInstitution,  DateTime issueDate,  DateTime? expirationDate,  String? credentialUrl, @JsonKey(includeFromJson: false, includeToJson: false)  File? credentialFile)  $default,) {final _that = this;
switch (_that) {
case _Certification():
return $default(_that.id,_that.name,_that.issuingInstitution,_that.issueDate,_that.expirationDate,_that.credentialUrl,_that.credentialFile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String issuingInstitution,  DateTime issueDate,  DateTime? expirationDate,  String? credentialUrl, @JsonKey(includeFromJson: false, includeToJson: false)  File? credentialFile)?  $default,) {final _that = this;
switch (_that) {
case _Certification() when $default != null:
return $default(_that.id,_that.name,_that.issuingInstitution,_that.issueDate,_that.expirationDate,_that.credentialUrl,_that.credentialFile);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Certification implements Certification {
  const _Certification({required this.id, this.name = '', this.issuingInstitution = '', required this.issueDate, this.expirationDate, this.credentialUrl, @JsonKey(includeFromJson: false, includeToJson: false) this.credentialFile});
  factory _Certification.fromJson(Map<String, dynamic> json) => _$CertificationFromJson(json);

@override final  String id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String issuingInstitution;
@override final  DateTime issueDate;
@override final  DateTime? expirationDate;
@override final  String? credentialUrl;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  File? credentialFile;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CertificationCopyWith<_Certification> get copyWith => __$CertificationCopyWithImpl<_Certification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CertificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Certification&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.issuingInstitution, issuingInstitution) || other.issuingInstitution == issuingInstitution)&&(identical(other.issueDate, issueDate) || other.issueDate == issueDate)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.credentialUrl, credentialUrl) || other.credentialUrl == credentialUrl)&&(identical(other.credentialFile, credentialFile) || other.credentialFile == credentialFile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,issuingInstitution,issueDate,expirationDate,credentialUrl,credentialFile);

@override
String toString() {
  return 'Certification(id: $id, name: $name, issuingInstitution: $issuingInstitution, issueDate: $issueDate, expirationDate: $expirationDate, credentialUrl: $credentialUrl, credentialFile: $credentialFile)';
}


}

/// @nodoc
abstract mixin class _$CertificationCopyWith<$Res> implements $CertificationCopyWith<$Res> {
  factory _$CertificationCopyWith(_Certification value, $Res Function(_Certification) _then) = __$CertificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String issuingInstitution, DateTime issueDate, DateTime? expirationDate, String? credentialUrl,@JsonKey(includeFromJson: false, includeToJson: false) File? credentialFile
});




}
/// @nodoc
class __$CertificationCopyWithImpl<$Res>
    implements _$CertificationCopyWith<$Res> {
  __$CertificationCopyWithImpl(this._self, this._then);

  final _Certification _self;
  final $Res Function(_Certification) _then;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? issuingInstitution = null,Object? issueDate = null,Object? expirationDate = freezed,Object? credentialUrl = freezed,Object? credentialFile = freezed,}) {
  return _then(_Certification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,issuingInstitution: null == issuingInstitution ? _self.issuingInstitution : issuingInstitution // ignore: cast_nullable_to_non_nullable
as String,issueDate: null == issueDate ? _self.issueDate : issueDate // ignore: cast_nullable_to_non_nullable
as DateTime,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,credentialUrl: freezed == credentialUrl ? _self.credentialUrl : credentialUrl // ignore: cast_nullable_to_non_nullable
as String?,credentialFile: freezed == credentialFile ? _self.credentialFile : credentialFile // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}


}

// dart format on
