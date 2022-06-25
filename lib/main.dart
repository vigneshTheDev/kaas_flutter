import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaas/components/bottom_navigation.dart';
import 'package:kaas/pages/add_transactions.dart';
import 'package:kaas/pages/home.dart';
import 'package:kaas/pages/quick_actions.dart';
import 'package:kaas/pages/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Kaas',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(textTheme),
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigation(
          _currentIndex,
          onChange: (int i) {
            setState(() {
              _currentIndex = i;
            });
          },
        ),
        body: IndexedStack(index: _currentIndex, children: const [
          Home(),
          AddTransactionPage(),
          QuickActionsPage(),
          Settings()
        ]),
      ),
    );
  }
}
