import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/features/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/custom_text_field.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/dynamic_list_section.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/form_label.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/shared_things.dart';
import 'package:uuid/uuid.dart';

class AddEducationModal extends StatefulWidget {
  final Education? education;

  const AddEducationModal({super.key, this.education});

  static Future<Education?> show(
    BuildContext context,
    Education? education,
  ) async {
    return await showModalBottomSheet<Education>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (ctx) => AddEducationModal(education: education),
    );
  }

  @override
  State<AddEducationModal> createState() => _AddEducationModalState();
}

class _AddEducationModalState extends State<AddEducationModal> {
  late TextEditingController _institutionController;
  late TextEditingController _degreeController;
  late TextEditingController _fieldOfStudyController;
  late TextEditingController _gpaController;

  DateTime? _startDate;
  DateTime? _endDate;
  List<String> _activities = [];

  // File state
  PlatformFile? _selectedGradCertificate;
  PlatformFile? _selectedAcademicRecord;

  bool _keepExistingGradCert = false;
  bool _keepExistingAcademicRecord = false;

  @override
  void initState() {
    super.initState();
    final edu = widget.education;
    _institutionController = TextEditingController(text: edu?.institutionName);
    _degreeController = TextEditingController(text: edu?.degreeType);
    _fieldOfStudyController = TextEditingController(text: edu?.fieldOfStudy);
    _gpaController = TextEditingController(text: edu?.gpa);

    if (edu != null) {
      _startDate = edu.startDate;
      _endDate = edu.endDate;
      _activities = List.from(edu.activities);
      _keepExistingGradCert = edu.graduationCertificateUrl != null;
      _keepExistingAcademicRecord = edu.academicRecordUrl != null;
    }
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _degreeController.dispose();
    _fieldOfStudyController.dispose();
    _gpaController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(bool isGradCert) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          if (isGradCert) {
            _selectedGradCertificate = result.files.first;
            _keepExistingGradCert = false; // We represent a NEW file now
          } else {
            _selectedAcademicRecord = result.files.first;
            _keepExistingAcademicRecord = false; // We represent a NEW file now
          }
        });
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error picking file: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _clearFile(bool isGradCert) {
    setState(() {
      if (isGradCert) {
        _selectedGradCertificate = null;
        _keepExistingGradCert = false;
      } else {
        _selectedAcademicRecord = null;
        _keepExistingAcademicRecord = false;
      }
    });
  }

  void _submit() {
    if (_institutionController.text.isEmpty ||
        _degreeController.text.isEmpty ||
        _fieldOfStudyController.text.isEmpty ||
        _startDate == null ||
        _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Missing required fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final gradUrlToSave =
        _selectedGradCertificate == null && _keepExistingGradCert
        ? widget.education?.graduationCertificateUrl
        : null;

    final academicUrlToSave =
        _selectedAcademicRecord == null && _keepExistingAcademicRecord
        ? widget.education?.academicRecordUrl
        : null;

    final newEducation = Education(
      id: widget.education?.id ?? const Uuid().v4(),
      institutionName: _institutionController.text,
      degreeType: _degreeController.text,
      fieldOfStudy: _fieldOfStudyController.text,
      startDate: _startDate!,
      endDate: _endDate!,
      gpa: _gpaController.text,
      activities: _activities,

      graduationCertificateBytes: _selectedGradCertificate?.bytes,
      graduationCertificateName: _selectedGradCertificate?.name,

      academicRecordBytes: _selectedAcademicRecord?.bytes,
      academicRecordName: _selectedAcademicRecord?.name,

      graduationCertificateUrl: gradUrlToSave,
      academicRecordUrl: academicUrlToSave,
    );

    Navigator.pop(context, newEducation);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.education != null;

    return BaseFormSheet(
      title: isEditing ? "Edit Education" : "Add Education",
      submitLabel: isEditing ? "Save Changes" : "Save Education",
      onSubmit: _submit,
      onCancel: () => Navigator.pop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormLabel("Institution Name"),
          CustomTextField(
            hint: "e.g. Harvard University",
            icon: Icons.account_balance,
            controller: _institutionController,
          ),
          SizedBox(height: 16.h),

          const FormLabel("Degree Type"),
          CustomTextField(
            hint: "e.g. Bachelor's",
            controller: _degreeController,
          ),
          SizedBox(height: 16.h),

          const FormLabel("Field of Study"),
          CustomTextField(
            hint: "e.g. Computer Science",
            controller: _fieldOfStudyController,
          ),
          SizedBox(height: 16.h),

          FormDateRow(
            startLabel: "Start Date",
            startDate: _startDate,
            onStartChanged: (d) => setState(() => _startDate = d),
            endLabel: "End Date",
            endDate: _endDate,
            onEndChanged: (d) => setState(() => _endDate = d),
          ),
          SizedBox(height: 16.h),

          const FormLabel("GPA (Optional)"),
          CustomTextField(hint: "e.g. 3.8/4.0", controller: _gpaController),
          SizedBox(height: 16.h),

          const FormLabel("Attachments"),
          Row(
            children: [
              Expanded(
                child: FormFileUploadButton(
                  label: "Graduation Cert.",
                  file: _selectedGradCertificate,
                  existingUrl: _keepExistingGradCert
                      ? widget.education?.graduationCertificateUrl
                      : null,
                  onTap: () => _pickFile(true),
                  onClear: () => _clearFile(true),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: FormFileUploadButton(
                  label: "Academic Record",
                  file: _selectedAcademicRecord,
                  existingUrl: _keepExistingAcademicRecord
                      ? widget.education?.academicRecordUrl
                      : null,
                  onTap: () => _pickFile(false),
                  onClear: () => _clearFile(false),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          DynamicListSection(
            title: "Activities & Societies",
            hintText: "Add activity...",
            items: _activities,
            onChanged: (list) => setState(() => _activities = list),
          ),
        ],
      ),
    );
  }
}
