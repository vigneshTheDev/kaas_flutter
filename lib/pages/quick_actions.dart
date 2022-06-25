import 'package:flutter/material.dart';

import 'package:kaas/components/simple_app_bar.dart';

class QuickActionsPage extends StatefulWidget {
  const QuickActionsPage({Key? key}) : super(key: key);

  @override
  State<QuickActionsPage> createState() => _QuickActionsPageState();
}

class _QuickActionsPageState extends State<QuickActionsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SimpleAppBar(title: 'Quick Actions'),
    );
  }
}
