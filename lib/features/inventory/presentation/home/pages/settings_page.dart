import 'package:flutter/material.dart';

/// Settings page for app configuration
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('settings'), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // App Info Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'معلومات التطبيق',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    context,
                    icon: Icons.info_outline,
                    title: 'إصدار التطبيق',
                    subtitle: '1.0.0',
                  ),
                  const Divider(),
                  _buildSettingItem(
                    context,
                    icon: Icons.description_outlined,
                    title: 'اسم التطبيق',
                    subtitle: 'Product Inventory',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Preferences Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التفضيلات',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    context,
                    icon: Icons.notifications_outlined,
                    title: 'الإشعارات',
                    subtitle: 'تفعيل الإشعارات',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // Handle notification toggle
                      },
                    ),
                  ),
                  const Divider(),
                  _buildSettingItem(
                    context,
                    icon: Icons.dark_mode_outlined,
                    title: 'الوضع الليلي',
                    subtitle: 'تفعيل الوضع الليلي',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {
                        // Handle dark mode toggle
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Support Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الدعم', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    context,
                    icon: Icons.help_outline,
                    title: 'مساعدة',
                    subtitle: 'الأسئلة الشائعة',
                    onTap: () {
                      // Navigate to help page
                    },
                  ),
                  const Divider(),
                  _buildSettingItem(
                    context,
                    icon: Icons.person_outline,
                    title: 'دعم المطور',
                    subtitle: 'تواصل مع المطور',
                    onTap: () {
                      Navigator.pushNamed(context, '/developer-support');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing,
            if (onTap != null && trailing == null)
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
