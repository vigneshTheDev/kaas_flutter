import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
  return userCredential;
}

Future<UserCredential> signInWithPassword() async {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: 'vignesh14thnov1991@gmail.com',
    password: '4eheismi',
  );

  return credential;
}

Future<String?> getUserId() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return null;
  }

  return user.uid;
}
