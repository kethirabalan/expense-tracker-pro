import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _currency = 'USD';
  bool _notifications = true;
  final Color blue = const Color(0xFF2979FF);

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Expense Tracker',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 Your Name',
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text('A simple expense tracker app built with Flutter.'),
        ),
      ],
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Backup'),
        content: const Text('Backup functionality coming soon!'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore'),
        content: const Text('Restore functionality coming soon!'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Settings', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFe3f0ff), Color(0xFFf8fbff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // User info card
              _GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: blue.withOpacity(0.1),
                        child: const Icon(Icons.person, color: Colors.black, size: 36),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Steven Paul', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 4),
                          Text('steven.paul@email.com', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // General settings card
              _GlassCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.attach_money, color: blue),
                        title: const Text('Currency'),
                        trailing: DropdownButton<String>(
                          value: _currency,
                          underline: const SizedBox(),
                          borderRadius: BorderRadius.circular(16),
                          items: const [
                            DropdownMenuItem(value: 'USD', child: Text('USD')),
                            DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                            DropdownMenuItem(value: 'INR', child: Text('INR')),
                            DropdownMenuItem(value: 'GBP', child: Text('GBP')),
                          ],
                          onChanged: (value) {
                            if (value != null) setState(() => _currency = value);
                          },
                        ),
                      ),
                      SwitchListTile(
                        secondary: Icon(Icons.notifications, color: blue),
                        title: const Text('Notifications'),
                        value: _notifications,
                        onChanged: (val) => setState(() => _notifications = val),
                        activeColor: blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Data card
              _GlassCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.backup, color: blue),
                        title: const Text('Backup'),
                        onTap: _showBackupDialog,
                      ),
                      ListTile(
                        leading: Icon(Icons.restore, color: blue),
                        title: const Text('Restore'),
                        onTap: _showRestoreDialog,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // About card
              _GlassCard(
                child: ListTile(
                  leading: Icon(Icons.info_outline, color: blue),
                  title: const Text('About'),
                  onTap: _showAboutDialog,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.2),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
} 