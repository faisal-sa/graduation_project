import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompanySettingsPage extends StatelessWidget {
  const CompanySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define colors locally or use your theme
    const backgroundColor = Color(0xFFF8F9FD);
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // 1. Modern Large Header
          SliverAppBar.large(
            backgroundColor: backgroundColor,
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          // 2. Settings List
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: 'Organization'),
                  _SettingsGroup(
                    children: [
                      _SettingsTile(
                        icon: Icons.business_rounded,
                        iconColor: Colors.blueAccent,
                        title: 'Company Profile',
                        subtitle: 'Manage details, industry & branding',
                        onTap: () =>
                            context.pushNamed('company-complete-profile'),
                      ),
                      _SettingsTile(
                        icon: Icons.people_outline_rounded,
                        iconColor: Colors.purpleAccent,
                        title: 'Team Members',
                        subtitle: 'Manage access and roles',
                        onTap: () {
                          // Navigate to team management
                        },
                        showDivider:
                            false, // Last item in group needs no divider
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _SectionHeader(title: 'Security & Account'),
                  _SettingsGroup(
                    children: [
                      _SettingsTile(
                        icon: Icons.lock_outline_rounded,
                        iconColor: Colors.orangeAccent,
                        title: 'Password & Security',
                        onTap: () {
                          // Navigate to change password
                        },
                      ),
                      _SettingsTile(
                        icon: Icons.notifications_none_rounded,
                        iconColor: Colors.teal,
                        title: 'Notifications',
                        onTap: () {},
                        showDivider: false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _SettingsGroup(
                    children: [
                      _SettingsTile(
                        icon: Icons.logout_rounded,
                        iconColor: Colors.redAccent,
                        title: 'Log Out',
                        textColor: Colors.redAccent,
                        showArrow: false,
                        showDivider: false,
                        onTap: () => _showLogoutConfirmation(context),
                      ),
                    ],
                  ),

                  // Version info footer
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 50),
                    child: Center(
                      child: Text(
                        'Version 1.0.0',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Log Out?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Are you sure you want to log out of your account?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close sheet
                        context.go('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Log Out'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HELPER WIDGETS
// -----------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool showDivider;
  final bool showArrow;
  final Color? textColor;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.showDivider = true,
    this.showArrow = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                // Icon Box
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 16),

                // Text Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor ?? Colors.black87,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Arrow
                if (showArrow)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.grey[300],
                  ),
              ],
            ),

            // Subtle Divider
            if (showDivider)
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 54),
                child: Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey[100],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
