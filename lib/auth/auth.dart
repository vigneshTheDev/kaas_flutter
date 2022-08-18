import 'package:firebase_auth/firebase_auth.dart';

Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
}
