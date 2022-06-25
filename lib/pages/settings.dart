import 'package:flutter/material.dart';
import 'package:kaas/components/simple_app_bar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SimpleAppBar(
        title: 'Settings',
      ),
    );
  }
}
