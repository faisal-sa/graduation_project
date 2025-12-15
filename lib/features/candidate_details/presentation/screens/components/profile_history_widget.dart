import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:graduation_project/features/candidate_details/domain/entities/candidate_profile_entity.dart';
import 'package:graduation_project/features/candidate_details/domain/entities/education_entity.dart';
import 'package:graduation_project/features/candidate_details/domain/entities/work_experience_entity.dart';
import 'package:graduation_project/features/candidate_details/domain/entities/certification_entity.dart';

class ProfileHistoryWidget extends StatelessWidget {
  final CandidateProfileEntity profile;

  const ProfileHistoryWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الخبرات
        _buildSectionTitle("Experience"),
        if (profile.experiences.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("No experience listed."),
          )
        else
          ...profile.experiences.map((e) => _buildExperienceItem(e)),
        Gap(20.h),

        // التعليم
        _buildSectionTitle("Education"),
        if (profile.educations.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("No education listed."),
          )
        else
          ...profile.educations.map((e) => _buildEducationItem(e)),
        Gap(20.h),

        // الشهادات
        _buildSectionTitle("Certifications"),
        if (profile.certifications.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("No certifications listed."),
          )
        else
          ...profile.certifications.map((c) => _buildCertificationItem(c)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildExperienceItem(WorkExperienceEntity exp) {
    return Card(
      margin: EdgeInsets.only(top: 10.h),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.work_outline, color: Colors.blue),
        ),
        title: Text(
          exp.jobTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exp.companyName, style: TextStyle(color: Colors.grey[700])),
            Text(
              "${exp.startDate.year} - ${exp.isCurrentlyWorking ? 'Present' : exp.endDate?.year}",
              style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationItem(EducationEntity edu) {
    return Card(
      margin: EdgeInsets.only(top: 10.h),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.school_outlined, color: Colors.orange),
        ),
        title: Text(
          edu.institutionName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(edu.degreeType),
            Text(edu.fieldOfStudy, style: TextStyle(color: Colors.grey[600])),
            Text(
              "${edu.startDate.year ?? ''} - ${edu.endDate?.year ?? ''}",
              style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificationItem(CertificationEntity cert) {
    return Card(
      margin: EdgeInsets.only(top: 10.h),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.workspace_premium, color: Colors.purple),
        ),
        title: Text(
          cert.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cert.issuingInstitution,
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(
              "Issued: ${cert.issueDate.year}",
              style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
