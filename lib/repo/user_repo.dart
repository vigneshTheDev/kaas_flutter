import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaas/firestore/user_doc.dart';

class UserRepo {
  DocumentReference<UserDoc> _getDocRef(String uid) {
    final instance = FirebaseFirestore.instance;

    final ref = instance.collection('users').doc(uid).withConverter(
        fromFirestore: UserDoc.fromFirestore,
        toFirestore: (UserDoc u, _) {
          return u.toFirestore();
        });
    return ref;
  }

  Future<UserDoc?> getUser(String uid) async {
    final docRef = _getDocRef(uid);
    final docSnap = await docRef.get();
    return docSnap.data();
  }

  Future<void> createUser(String uid) async {
    final docRef = _getDocRef(uid);
    await docRef.set(UserDoc(uid));
  }
}
