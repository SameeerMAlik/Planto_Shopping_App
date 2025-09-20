import 'package:firebase_database/firebase_database.dart';
import '../../core/exceptions/app_exceptions.dart';
import '../models/user_model.dart';

// Database Service - Handles Firebase Realtime Database operations
class DatabaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Save user data to database
  Future<void> saveUserData({
    required String uid,
    required UserModel user,
  }) async {
    try {
      await _database.child('users').child(uid).set(user.toJson());
    } catch (e) {
      throw DatabaseException('Failed to save user data');
    }
  }

  // Get user data from database
  Future<UserModel?> getUserData(String uid) async {
    try {
      final DatabaseEvent event = await _database.child('users').child(uid).once();

      if (event.snapshot.exists) {
        final userData = event.snapshot.value as Map<String, dynamic>;
        return UserModel.fromFirebase(
          uid: uid,
          email: userData['email'],
          userData: userData,
        );
      }

      return null;
    } catch (e) {
      throw DatabaseException('Failed to fetch user data');
    }
  }

  // Update user data
  Future<void> updateUserData({
    required String uid,
    required Map<String, dynamic> updates,
  }) async {
    try {
      await _database.child('users').child(uid).update(updates);
    } catch (e) {
      throw DatabaseException('Failed to update user data');
    }
  }

  // Delete user data
  Future<void> deleteUserData(String uid) async {
    try {
      await _database.child('users').child(uid).remove();
    } catch (e) {
      throw DatabaseException('Failed to delete user data');
    }
  }

  // Check if user exists
  Future<bool> userExists(String uid) async {
    try {
      final DatabaseEvent event = await _database.child('users').child(uid).once();
      return event.snapshot.exists;
    } catch (e) {
      throw DatabaseException('Failed to check user existence');
    }
  }
}