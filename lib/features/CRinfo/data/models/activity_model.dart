import 'package:equatable/equatable.dart';
import '../../domain/entities/activity.dart';

class ActivityModel extends Equatable {
  final String id;
  final String name;

  const ActivityModel({required this.id, required this.name});

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  Activity toEntity() {
    return Activity(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
