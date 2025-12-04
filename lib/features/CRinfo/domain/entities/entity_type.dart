import 'package:equatable/equatable.dart';

class EntityType extends Equatable {
  final int id;
  final String name;
  final int? formId;
  final String? formName;
  final List<String> characters;

  const EntityType({
    required this.id,
    required this.name,
    this.formId,
    this.formName,
    required this.characters,
  });

  @override
  List<Object?> get props => [id, name, formId, formName, characters];
}

