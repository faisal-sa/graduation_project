import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompanySettingsPage extends StatelessWidget {
  const CompanySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Edit Company Profile'),
            subtitle: const Text('Update description, industry, etc.'),
            onTap: () {
              context.goNamed('company-complete-profile');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () {
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}
