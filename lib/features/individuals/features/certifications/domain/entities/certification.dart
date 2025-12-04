import 'dart:io';

import 'package:equatable/equatable.dart';

class Certification extends Equatable {
  final String id;
  final String name;
  final String issuingInstitution;
  final DateTime issueDate;
  final DateTime? expirationDate;
  final File? credentialFile;

  final String? credentialUrl;
  const Certification({
    required this.id,
    required this.name,
    required this.issuingInstitution,
    required this.issueDate,
    this.expirationDate,
    this.credentialFile,
    this.credentialUrl,
  });

  

  @override
  List<Object?> get props => [
    id,
    name,
    issuingInstitution,
    issueDate,
    expirationDate,
    credentialFile,
    credentialUrl,
  ];
}
