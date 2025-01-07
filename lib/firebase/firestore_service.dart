import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addService(Service service) async {
    try {
      await _db.collection('services').doc(service.id).set(service.toMap());
    } catch (e) {
      print('Error adding service: $e');
    }
  }

  Future<List<Service>> getServices() async {
    try {
      QuerySnapshot snapshot = await _db.collection('services').get();
      return snapshot.docs.map((doc) {
        return Service.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching services: $e');
      return [];
    }
  }

  Future<void> updateService(Service service) async {
    try {
      await _db.collection('services').doc(service.id).update(service.toMap());
    } catch (e) {
      print('Error updating service: $e');
    }
  }

  Future<void> deleteService(String id) async {
    try {
      await _db.collection('services').doc(id).delete();
    } catch (e) {
      print('Error deleting service: $e');
    }
  }
}
