// lib/services/user_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getEmailFromUsername(String username) async {
    try {
      final lowerCaseUsername = username.trim().toLowerCase();
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('username', isEqualTo: lowerCaseUsername)
          .get();

      if (result.docs.isNotEmpty) {
        return result.docs.first['email'];
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération de l\'email : $e');
    }
    return null;
  }
}
