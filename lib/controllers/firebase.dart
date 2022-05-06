import 'package:cloud_firestore/cloud_firestore.dart';

// Informações referentes ao BD.
class Firebase {
  // Construtor privado.
  Firebase._();

  static final Firebase _instance = Firebase._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Retorna o firestore.
  static FirebaseFirestore getFirestore() {
    return Firebase._instance._firestore;
  }
}
