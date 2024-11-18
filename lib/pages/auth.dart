import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //Sign in with email and password
  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  //Sign up with email and password
  Future<void> signUp(String name, String email, String password) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After creating the user, save additional info (like name) in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
        // Add any other fields as needed
      });
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }


  //Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}