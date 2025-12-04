import 'package:equatable/equatable.dart';

class Status extends Equatable {
  final int id;
  final String name;

  const Status({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

