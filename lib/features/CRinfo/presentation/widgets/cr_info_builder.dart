import 'package:flutter/material.dart';
import '../../domain/entities/cr_info.dart';

class CrInfoBuilder extends StatelessWidget {
  final CrInfo data;

  const CrInfoBuilder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Company name widget
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.shade100.withAlpha(35),
                Colors.blueAccent.shade100.withAlpha(10),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(18),
                offset: const Offset(0, 8),
                blurRadius: 32,
              ),
            ],
          ),
          child: Center(
            child: Text(
              data.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.black12,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Company info tiles
        _tile("رقم السجل", data.crNumber),
        _tile("الرقم الوطني", data.crNationalNumber),
        _tile("رقم الإصدار", data.versionNo.toString()),
        _tile("المدينة", data.headquarterCityName),
        _tile("تاريخ التأسيس (ميلادي)", data.issueDateGregorian),
        _tile("تاريخ التأسيس (هجري)", data.issueDateHijri),
        if (data.companyDuration != null)
          _tile("المدة", data.companyDuration!),
        _tile("نوع الكيان", data.entityType.name),
        if (data.entityType.formName != null)
          _tile("الشكل القانوني", data.entityType.formName!),
        _tile("الحالة", data.status.name),
        _tile("سجل رئيسي", data.isMain ? "نعم" : "لا"),
        _tile("في عملية تصفية", data.inLiquidationProcess ? "نعم" : "لا"),
        _tile("لديه تجارة إلكترونية", data.hasEcommerce ? "نعم" : "لا"),
        _tile("قائم على ترخيص", data.isLicenseBased ? "نعم" : "لا"),
        if (data.mainCrNumber != null)
          _tile("رقم السجل الرئيسي", data.mainCrNumber!),
        if (data.mainCrNationalNumber != null)
          _tile("الرقم الوطني للسجل الرئيسي", data.mainCrNationalNumber!),

        // Character list
        if (data.entityType.characters.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            "الخصائص:",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.blueAccent.shade100,
            ),
          ),
          ...data.entityType.characters.map(
            (character) => ListTile(
              title: Text(character, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ],
        const SizedBox(height: 16),

        // Activities
        Text(
          "الأنشطة:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blueAccent.shade100,
          ),
        ),
        if (data.activities.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "لا توجد أنشطة مسجلة",
              style: TextStyle(color: Colors.grey.shade400),
            ),
          )
        else
          ...data.activities.map(
            (e) => ListTile(
              title: Text(e.name, style: const TextStyle(color: Colors.white)),
              subtitle: Text(
                "ID: ${e.id}",
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
          ),
      ],
    );
  }

  Widget _tile(String title, String value) {
    return Card(
      color: const Color(0xFF262626),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: Colors.blueAccent.shade100)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}

