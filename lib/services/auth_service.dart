import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String error = ''; // Error message

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      _handleUnexpectedError(e);
    }
    throw Exception('Sign up failed');
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      _handleUnexpectedError(e);
    }
    throw Exception('Sign in failed');
  }

  // Helper function to handle FirebaseAuthException
  void _handleAuthException(FirebaseAuthException e) {
    // Specific error handling based on Firebase Authentication exceptions
    if (e.code == 'weak-password') {
      error = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      error = 'The account already exists for that email.';
    } else if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      error = 'Invalid email or password.';
    } else {
      error = 'An unknown error occurred.';
    }
  }

  // Helper function to handle unexpected errors
  void _handleUnexpectedError(dynamic e) {
    error = 'An unexpected error occurred during authentication.';
  }
}
