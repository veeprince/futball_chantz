import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final CollectionReference _collectionReference =
      _firebaseFirestore.collection('Device');

  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future<void> addUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }
  //  Stream<DocumentSnapshot> getChecklist() {
  //   CollectionReference checklistItemCollection = _collectionReference;

  //   return checklistItemCollection.();
  // }

}
