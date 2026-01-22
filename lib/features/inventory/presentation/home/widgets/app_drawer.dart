import 'package:flutter/material.dart';

/// Reusable drawer widget for navigation menu
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.inventory_2, size: 48, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  'Product Inventory',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'إدارة المخزون',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),

          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'الإعدادات',
            subtitle: 'Settings',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person_outline,
            title: 'دعم المطور',
            subtitle: 'Developer Support',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/developer-support');
            },
          ),

          _buildDrawerItem(
            context,
            icon: Icons.info_outline,
            title: 'حول التطبيق',
            subtitle: 'About',
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حول التطبيق'),
        content: const Text(
          'Product Inventory App\n\nتطبيق إدارة المخزون\nالإصدار: 1.0.0',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }
}
