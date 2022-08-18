import 'package:cloud_firestore/cloud_firestore.dart';

class UserDoc {
  final String uid;

  const UserDoc(this.uid);

  factory UserDoc.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserDoc(data?['uid']);
  }

  Map<String, dynamic> toFirestore() {
    return {"uid": uid};
  }
}
