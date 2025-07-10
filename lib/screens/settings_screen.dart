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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Settings', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // User info card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              leading: Icon(Icons.info_outline, color: blue),
              title: const Text('About'),
              onTap: _showAboutDialog,
            ),
          ),
        ],
      ),
    );
  }
} 