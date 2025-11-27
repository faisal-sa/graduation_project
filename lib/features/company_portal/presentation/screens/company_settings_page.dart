import 'package:flutter/material.dart';

class CompanySettingsPage extends StatelessWidget {
  const CompanySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعدادات الشركة')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text('تغيير كلمة المرور'),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.notifications_active_outlined),
            title: Text('إدارة التنبيهات'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('تسجيل الخروج'),
            onTap: () {
              // هنا يمكن تنفيذ logout الحقيقي
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
