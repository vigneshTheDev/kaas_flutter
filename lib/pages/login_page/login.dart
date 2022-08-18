import 'package:flutter/material.dart';
import 'package:kaas/auth/google.dart';
import 'package:kaas/repo/user_repo.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLogin;
  const LoginPage({Key? key, required this.onLogin}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  final UserRepo userRepo = UserRepo();

  void _signInWithGoogle(BuildContext context) async {
    setState(() {
      _loading = true;
    });
    try {
      final userCreds = await signInWithPassword(); // await signInWithGoogle();

      if (userCreds.user != null) {
        final userDoc = await userRepo.getUser(userCreds.user!.uid);

        if (userDoc == null) {
          await userRepo.createUser(userCreds.user!.uid);
        }

        widget.onLogin();
        return;
      }
    } catch (e) {
      print('Error: $e');
      const snack = SnackBar(
        content: Text('Something went wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _loading
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                _signInWithGoogle(context);
              },
              child: const Text('Login with Google')),
    );
  }
}
