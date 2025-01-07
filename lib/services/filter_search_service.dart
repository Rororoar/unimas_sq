import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_model.dart';

class FilterSearchService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get services filtered by price range and rating.
  Future<List<Service>> filterServices({
    required double minPrice,
    required double maxPrice,
    required double minRating,
  }) async {
    try {
      QuerySnapshot snapshot = await _db.collection('services')
          .where('price', isGreaterThanOrEqualTo: minPrice)
          .where('price', isLessThanOrEqualTo: maxPrice)
          .where('rating', isGreaterThanOrEqualTo: minRating)
          .get();

      return snapshot.docs.map((doc) {
        return Service.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error filtering services: $e');
      return [];
    }
  }

  /// Search services by title.
  Future<List<Service>> searchServices(String query) async {
    try {
      QuerySnapshot snapshot = await _db.collection('services')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      return snapshot.docs.map((doc) {
        return Service.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error searching services: $e');
      return [];
    }
  }

  /// Combined filter and search services.
  Future<List<Service>> filterAndSearchServices({
    required String searchQuery,
    required double minPrice,
    required double maxPrice,
    required double minRating,
  }) async {
    try {
      QuerySnapshot snapshot = await _db.collection('services')
          .where('title', isGreaterThanOrEqualTo: searchQuery)
          .where('title', isLessThanOrEqualTo: searchQuery + '\uf8ff')
          .where('price', isGreaterThanOrEqualTo: minPrice)
          .where('price', isLessThanOrEqualTo: maxPrice)
          .where('rating', isGreaterThanOrEqualTo: minRating)
          .get();

      return snapshot.docs.map((doc) {
        return Service.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error filtering and searching services: $e');
      return [];
    }
  }
}
