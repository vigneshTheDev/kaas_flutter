import 'package:flutter/material.dart';
import 'package:kaas/auth/auth.dart';
import 'package:kaas/shared_components/simple_app_bar.dart';
import 'package:kaas/shared_components/x_space.dart';

class Settings extends StatefulWidget {
  final VoidCallback onLogout;
  const Settings({Key? key, required this.onLogout}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(
        title: 'Settings',
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              await logout();
              widget.onLogout();
            },
            child: Row(children: const [
              Icon(Icons.logout),
              XSpace(16),
              Text('Log out')
            ]),
          ),
        )
      ]),
    );
  }
}
