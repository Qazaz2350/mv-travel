import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up user with email & password
  Future<User?> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'fullName': fullName,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      // Map Firebase error codes to custom messages
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'This email is already registered.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'weak-password':
          message = 'The password is too weak.';
          break;
        default:
          message = 'Registration failed. Please try again.';
      }
      throw message;
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  // ✅ Sign in user with email & password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No account found for this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          message = 'The email address is invalid.';
          break;
        default:
          message = 'Failed to sign in. Please try again.';
      }
      throw message;
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }
}
