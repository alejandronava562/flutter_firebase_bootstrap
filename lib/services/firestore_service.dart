import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  // Save a list of items for a category
  Future<void> saveCategoryItems(String categoryID, List<String> items) async {
    await _db.collection('users').doc(_uid).set(
      {categoryID: items},
      SetOptions(merge: true),
    ); // merge so it doesn't overwrite other categories
  }

  // Load items for a category
  Future<List<String>> getCategoryItems(String categoryID) async {
    final doc = await _db.collection('users').doc(_uid).get();
    {
      if (doc.exists && doc.data()![categoryID] != null) {
        return List<String>.from(doc[categoryID]);
      }
    }
    return [];
  }
}
