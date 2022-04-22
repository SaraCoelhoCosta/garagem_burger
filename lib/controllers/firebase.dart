import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase {
  // ??
  late User firebaseUser;

  // Firebade para autenticação e criação de usuário.
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // ??
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}
