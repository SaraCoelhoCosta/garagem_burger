import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Firebase {
  // Construtor privado.
  Firebase._();

  static final Firebase _instance = Firebase._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Retorna o Storage (Armazenamento de Arquivos)
  static FirebaseStorage getStorage() {
    return Firebase._instance._storage;
  }

  // Retorna o Firestore (Armazenamento de Dados)
  static FirebaseFirestore getFirestore() {
    return Firebase._instance._firestore;
  }
}
