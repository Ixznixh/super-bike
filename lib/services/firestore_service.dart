import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/superbike_data.dart';
import '../models/superbike_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection Reference
  CollectionReference<Map<String, dynamic>> get _bikesRef =>
      _db.collection('superbikes');

  // Real-time Stream of Superbikes uploaded & stored in Firebase
  Stream<List<Superbike>> get bikesStream {
    return _bikesRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Superbike.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  // Upload a New Superbike to Firestore Cloud
  Future<void> uploadSuperbike(Superbike bike) async {
    await _bikesRef.doc(bike.id).set(bike.toMap());
  }

  // Sync and Seed All Initial Flagship Superbikes to Firebase Firestore
  Future<void> syncAllBikesToFirebase() async {
    try {
      final snapshot = await _bikesRef.get();
      // If collection has fewer docs than initial bikes, seed all initial bikes to Firestore
      if (snapshot.docs.length < SuperbikeData.initialBikes.length) {
        for (var bike in SuperbikeData.initialBikes) {
          await _bikesRef.doc(bike.id).set(bike.toMap(), SetOptions(merge: true));
        }
      }
    } catch (e) {
      // Print debug info if offline or permission pending
      print('Firestore sync info: $e');
    }
  }
}
