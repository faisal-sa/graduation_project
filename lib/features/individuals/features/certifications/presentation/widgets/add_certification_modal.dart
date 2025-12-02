import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/custom_text_field.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/form_label.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/shared_things.dart';
import 'package:uuid/uuid.dart';

class AddCertificationModal extends StatefulWidget {
  final Certification? certification;

  const AddCertificationModal({super.key, this.certification});

  static Future<Certification?> show(
    BuildContext context,
    Certification? certification,
  ) async {
    return await showModalBottomSheet<Certification>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (ctx) => AddCertificationModal(certification: certification),
    );
  }

  @override
  State<AddCertificationModal> createState() => _AddCertificationModalState();
}

class _AddCertificationModalState extends State<AddCertificationModal> {
  late TextEditingController _nameController;
  late TextEditingController _issuingInstitutionController;

  DateTime? _issueDate;
  DateTime? _expirationDate;

  bool _hasCredentialFile = false;

  @override
  void initState() {
    super.initState();
    final cert = widget.certification;
    _nameController = TextEditingController(text: cert?.name);
    _issuingInstitutionController = TextEditingController(
      text: cert?.issuingInstitution,
    );

    if (cert != null) {
      _issueDate = cert.issueDate;
      _expirationDate = cert.expirationDate;
      _hasCredentialFile = cert.credentialFile != null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _issuingInstitutionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameController.text.isEmpty ||
        _issuingInstitutionController.text.isEmpty ||
        _issueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Missing required fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newCertification = Certification(
      id: widget.certification?.id ?? const Uuid().v4(),
      name: _nameController.text,
      issuingInstitution: _issuingInstitutionController.text,
      issueDate: _issueDate!,
      expirationDate: _expirationDate,
      credentialFile: _hasCredentialFile
          ? File("path/to/credential.pdf")
          : null,
    );

    Navigator.pop(context, newCertification);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.certification != null;

    return BaseFormSheet(
      title: isEditing ? "Edit Certification" : "Add Certification",
      submitLabel: isEditing ? "Save Changes" : "Save Certification",
      onSubmit: _submit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormLabel("Certification Name"),
          CustomTextField(
            hint: "e.g. AWS Certified Solutions Architect",
            icon: Icons.badge_outlined,
            controller: _nameController,
          ),
          SizedBox(height: 16.h),

          const FormLabel("Issuing Organization"),
          CustomTextField(
            hint: "e.g. Amazon Web Services",
            controller: _issuingInstitutionController,
          ),
          SizedBox(height: 16.h),

          FormDateRow(
            startLabel: "Issue Date",
            startDate: _issueDate,
            onStartChanged: (d) => setState(() => _issueDate = d),
            endLabel: "Expiration (Optional)",
            endDate: _expirationDate,
            onEndChanged: (d) => setState(() => _expirationDate = d),
            endPlaceholder: "No Expiry",
          ),
          SizedBox(height: 16.h),

          const FormLabel("Credential File"),
          FormFileUploadButton(
            label: "Upload Certificate",
            isSelected: _hasCredentialFile,
            onTap: () {
              setState(() {
                _hasCredentialFile = !_hasCredentialFile;
              });
            },
            onClear: _hasCredentialFile
                ? () => setState(() => _hasCredentialFile = false)
                : null,
          ),
        ],
      ),
    );
  }
}
