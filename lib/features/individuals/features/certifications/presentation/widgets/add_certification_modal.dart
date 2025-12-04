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

<<<<<<< HEAD
    return BaseFormSheet(
      title: isEditing ? "Edit Certification" : "Add Certification",
      submitLabel: isEditing ? "Save Changes" : "Save Certification",
      onSubmit: _submit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
=======
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? "Edit Certification" : "Add Certification",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Form Body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: const _CertificationFormBody(),
              ),
            ),

            // Submit Button
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child:
                      BlocBuilder<
                        CertificationFormCubit,
                        CertificationFormState
                      >(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state.status == FormStatus.loading
                                ? null
                                : () => context
                                      .read<CertificationFormCubit>()
                                      .submitForm(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B82F6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                            ),
                            child: state.status == FormStatus.loading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    isEditing
                                        ? "Save Changes"
                                        : "Save Certification",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          );
                        },
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CertificationFormBody extends StatelessWidget {
  const _CertificationFormBody();

  void _showDatePicker(BuildContext context, bool isIssueDate) {
    final cubit = context.read<CertificationFormCubit>();
    final initial = isIssueDate
        ? (cubit.state.issueDate ?? DateTime.now())
        : (cubit.state.expirationDate ?? DateTime.now());

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (_) => SizedBox(
        height: 250.h,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoButton(
                  child: const Text('Done'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: initial,
                mode: CupertinoDatePickerMode.date, // or monthYear
                onDateTimeChanged: (val) => isIssueDate
                    ? cubit.issueDateChanged(val)
                    : cubit.expirationDateChanged(val),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CertificationFormCubit, CertificationFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Label("Certification Name"),
            _TextField(
              hint: "e.g. AWS Certified Solutions Architect",
              icon: Icons.badge_outlined,
              initialValue: state.name,
              onChanged: (v) =>
                  context.read<CertificationFormCubit>().nameChanged(v),
            ),
            SizedBox(height: 16.h),

            _Label("Issuing Organization"),
            _TextField(
              hint: "e.g. Amazon Web Services",
              initialValue: state.issuingInstitution,
              onChanged: (v) => context
                  .read<CertificationFormCubit>()
                  .issuingInstitutionChanged(v),
            ),
            SizedBox(height: 16.h),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Label("Issue Date"),
                      GestureDetector(
                        onTap: () => _showDatePicker(context, true),
                        child: _DateBox(
                          date: state.issueDate,
                          placeholder: "Select",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Label("Expiration (Optional)"),
                      GestureDetector(
                        onTap: () => _showDatePicker(context, false),
                        child: _DateBox(
                          date: state.expirationDate,
                          placeholder: "No Expiry",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            _Label("Credential File"),
            _FileButton(
              label: "Upload Certificate",
              isFileSelected: state.credentialFile != null,
              onTap: () {
                // Trigger file picker
                // context.read<CertificationFormCubit>().setCredentialFile(file);
              },
            ),

            SizedBox(height: 100.h),
          ],
        );
      },
    );
  }
}

// Reuse the helpers (_Label, _TextField, _DateBox, _FileButton, _inputDeco)
// from your Education code here. They are identical.

// -----------------------------------------------------------------------------
// HELPER WIDGETS
// -----------------------------------------------------------------------------

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.grey[800],
      ),
    ),
  );
}

class _TextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? initialValue;

  const _TextField({
    this.controller,
    this.hint = '',
    this.icon,
    this.onChanged,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    initialValue: initialValue,
    controller: controller,
    onChanged: onChanged,
    style: TextStyle(fontSize: 14.sp),
    decoration: _inputDeco(hint: hint, icon: icon),
  );
}

class _DateBox extends StatelessWidget {
  final DateTime? date;
  final String placeholder;
  const _DateBox({this.date, required this.placeholder});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
>>>>>>> origin/payments_new
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
