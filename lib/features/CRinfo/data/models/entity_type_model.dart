import 'package:equatable/equatable.dart';
import '../../domain/entities/entity_type.dart';

class EntityTypeModel extends Equatable {
  final int id;
  final String name;
  final int? formId;
  final String? formName;
  final List<String> characters;

  const EntityTypeModel({
    required this.id,
    required this.name,
    this.formId,
    this.formName,
    required this.characters,
  });

  factory EntityTypeModel.fromJson(Map<String, dynamic> json) {
    return EntityTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      formId: json['formId'] as int?,
      formName: json['formName'] as String?,
      characters:
          (json['characters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  EntityType toEntity() {
    return EntityType(
      id: id,
      name: name,
      formId: formId,
      formName: formName,
      characters: characters,
    );
  }

  @override
  List<Object?> get props => [id, name, formId, formName, characters];
}
