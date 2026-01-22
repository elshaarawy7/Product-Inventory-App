import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

/// Developer support page with contact information
class DeveloperSupportPage extends StatelessWidget {
  const DeveloperSupportPage({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('دعم المطور'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar Section
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage('assets/profile/profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Developer Name
            Text(
              "Elshaarawy hassan",
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Flutter Developer',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            // Social Media Links
            Text('تواصل معي', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),

            // Instagram
            _buildSocialCard(
              context,
              icon: Ionicons.logo_instagram,
              title: 'Instagram',
              subtitle: 'تابعني على الإنستجرام',
              color: const Color(0xFFE4405F),
              onTap: () {
                _launchURL('https://www.instagram.com/stevan_official_17?igsh=MWpwdGw3djQ3MWxlOQ%3D%3D');
              },
            ),
            const SizedBox(height: 16),

            // LinkedIn
            _buildSocialCard(
              context,
              icon: Ionicons.logo_linkedin,
              title: 'LinkedIn',
              subtitle: 'تواصل معي على لينكد إن',
              color: const Color(0xFF0077B5),
              onTap: () {
                _launchURL('https://www.linkedin.com/in/elshaarawy-hassan-6020002b6/');
              },
            ),
            const SizedBox(height: 16),

            // WhatsApp
            _buildSocialCard(
              context,
              icon: Ionicons.logo_whatsapp,
              title: 'WhatsApp',
              subtitle: 'راسلني على واتساب',
              color: const Color(0xFF25D366),
              onTap: () {
                // Replace with your WhatsApp number (with country code, no +)
                _launchURL('https://wa.me/01220117580');
              },
            ),
            const SizedBox(height: 32),
             // emil
            _buildSocialCard(
              context,
              icon: Ionicons.mail,
              title: 'emil',
              subtitle: 'راسلني على الايميل',
              color: const Color(0xFF25D366),
              onTap: () {
                // Replace with your WhatsApp number (with country code, no +)
                _launchURL('elshaarawyhassan7@gmail.com');
              },
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildSocialCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
