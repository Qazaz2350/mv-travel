import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactProfileScreen extends StatelessWidget {
  const ContactProfileScreen({super.key});

  final String name = 'Mam Hifza kanwal';
  final String username = '~Hifza kanwal';
  final String phoneNumber = '03281223062';
  final String email = 'hifahtechnologiesofficial@gmail.com';
  final String description = 'I offer App & Web develooment Services.';
  final String category = 'Information technology company';

  void _makeCall(BuildContext context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      _showSnackBar(context, 'Could not make call', Colors.red);
    }
  }

  void _openWhatsApp(BuildContext context) async {
    final whatsappUrl = Uri.parse(
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent('Hello!')}",
    );

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      _showSnackBar(context, 'Could not open WhatsApp', Colors.red);
    }
  }

  void _sendEmail(BuildContext context) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      _showSnackBar(context, 'Could not open email', Colors.red);
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1929),
      body: CustomScrollView(
        slivers: [
          // Header with logo
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF0A1929),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    'assets/logo.png', // Replace with your logo asset
                    height: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return Column(
                        children: const [
                          Text(
                            'Visions',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF4DD0E1),
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            'We Care',
                            style: TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Profile Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Avatar and Name
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF6B2E5F),
                    border: Border.all(
                      color: const Color(0xFF1E3A5F),
                      width: 4,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'MK',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF4081),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),

                // Username
                Text(
                  username,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 24),

                // Call and Share Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => _makeCall(context),
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xFF4DD0E1),
                                width: 1.5,
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Color(0xFF4DD0E1),
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Call',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () => _openWhatsApp(context),
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xFF4DD0E1),
                                width: 1.5,
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Color(0xFF4DD0E1),
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Share',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.description,
                        color: Colors.grey.shade400,
                        size: 20,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade300,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Divider
                Divider(
                  color: Colors.grey.shade800,
                  thickness: 1,
                  indent: 24,
                  endIndent: 24,
                ),
                const SizedBox(height: 8),

                // Hours Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'Open now',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '2:00 – 6:00 pm',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildHourRow('Thursday', '2:00 – 6:00 pm'),
                      _buildHourRow('Friday', '2:00 – 6:00 pm'),
                      _buildHourRow('Saturday', '2:00 – 6:00 pm'),
                      _buildHourRow('Sunday', 'Closed', isClosed: true),
                      _buildHourRow('Monday', '2:00 – 6:00 pm'),
                      _buildHourRow('Tuesday', '2:00 – 6:00 pm'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Divider
                Divider(
                  color: Colors.grey.shade800,
                  thickness: 1,
                  indent: 24,
                  endIndent: 24,
                ),
                const SizedBox(height: 8),

                // Category
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Icon(
                        Icons.business,
                        color: Colors.grey.shade400,
                        size: 20,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Divider
                Divider(
                  color: Colors.grey.shade800,
                  thickness: 1,
                  indent: 24,
                  endIndent: 24,
                ),
                const SizedBox(height: 8),

                // Email
                InkWell(
                  onTap: () => _sendEmail(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            email,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF4DD0E1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourRow(String day, String hours, {bool isClosed = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 36),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              day,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
            ),
          ),
          const Spacer(),
          Text(
            hours,
            style: TextStyle(
              fontSize: 14,
              color: isClosed ? Colors.grey.shade600 : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
