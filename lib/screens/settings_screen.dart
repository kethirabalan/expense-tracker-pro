import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _currency = 'USD';
  bool _notifications = true;

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
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('General', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Currency'),
            subtitle: Text(_currency),
            trailing: DropdownButton<String>(
              value: _currency,
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
            secondary: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            value: _notifications,
            onChanged: (val) => setState(() => _notifications = val),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('Backup'),
            onTap: _showBackupDialog,
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Restore'),
            onTap: _showRestoreDialog,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('About', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: _showAboutDialog,
          ),
        ],
      ),
    );
  }
} 