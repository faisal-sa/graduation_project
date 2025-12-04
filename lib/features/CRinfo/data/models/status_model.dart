import 'package:equatable/equatable.dart';
import '../../domain/entities/status.dart';

class StatusModel extends Equatable {
  final int id;
  final String name;

  const StatusModel({
    required this.id,
    required this.name,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Status toEntity() {
    return Status(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}

