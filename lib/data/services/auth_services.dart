import 'package:firebase_auth/firebase_auth.dart';
import '../../core/exceptions/app_exceptions.dart';
import '../models/user_model.dart';

// Authentication Service - Handles Firebase Auth operations
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Get current user stream
  Stream<User?> get userStream => _firebaseAuth.authStateChanges();

  // Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Sign up with email and password
  Future<User> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        throw const AuthenticationException('Failed to create user account');
      }

      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(ExceptionHandler.getErrorMessage(e));
    } catch (e) {
      throw AuthenticationException(ExceptionHandler.getErrorMessage(e as Exception));
    }
  }

  // Sign in with email and password
  Future<User> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        throw const AuthenticationException('Failed to sign in');
      }

      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(ExceptionHandler.getErrorMessage(e));
    } catch (e) {
      throw AuthenticationException(ExceptionHandler.getErrorMessage(e as Exception));
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthenticationException('Failed to sign out');
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(ExceptionHandler.getErrorMessage(e));
    } catch (e) {
      throw AuthenticationException('Failed to send password reset email');
    }
  }

  // Delete user account
  Future<void> deleteAccount() async {
    try {
      final user = currentUser;
      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      throw AuthenticationException('Failed to delete account');
    }
  }
}