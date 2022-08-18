import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kaas/auth/google.dart';
import 'package:kaas/shared_components/bottom_navigation.dart';
import 'package:kaas/pages/add_transactions_page/add_transactions.dart';
import 'package:kaas/pages/home_page/home.dart';
import 'package:kaas/pages/login_page/login.dart';
import 'package:kaas/pages/quick_actions_page/quick_actions.dart';
import 'package:kaas/pages/settings_page/settings.dart';
import 'package:kaas/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    getUserId().then((uid) {
      setState(() {
        _loggedIn = uid != null;
      });
    });
  }

  _onLogin() {
    setState(() {
      _loggedIn = true;
    });
  }

  _onLogout() {
    setState(() {
      _loggedIn = false;
      _currentIndex = 0;
    });
  }

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
        bottomNavigationBar: _loggedIn
            ? BottomNavigation(
                _currentIndex,
                onChange: (int i) {
                  setState(() {
                    _currentIndex = i;
                  });
                },
              )
            : null,
        body: _loggedIn
            ? IndexedStack(index: _currentIndex, children: [
                const Home(),
                const AddTransactionsPage(),
                const QuickActionsPage(),
                Settings(
                  onLogout: _onLogout,
                )
              ])
            : LoginPage(
                onLogin: () {
                  _onLogin();
                },
              ),
      ),
    );
  }
}
