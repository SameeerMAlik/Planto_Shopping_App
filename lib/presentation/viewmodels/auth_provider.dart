import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// AuthProvider class manages all authentication logic
class AuthProvider with ChangeNotifier {
  // Firebase Auth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Firebase Database instance
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Current user
  User? _user;

  // User role (admin or customer)
  String? _userRole;

  // Loading state
  bool _isLoading = false;

  // Error message
  String? _errorMessage;

  // Getters - Allow other widgets to access these values
  User? get user => _user;
  String? get userRole => _userRole;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;

  // Add this method to your AuthProvider class
  Future<void> initializeAuth() async {
    try {
      // Check current authentication state
      _user = _firebaseAuth.currentUser;

      if (_user != null) {
        print('User found: ${_user!.uid}');
        // User is logged in, fetch their role
        await _fetchUserRole();
        print('User role: $_userRole');
      } else {
        print('No user logged in');
      }

      notifyListeners();
    } catch (e) {
      print('Error initializing auth: $e');
      _setError('Failed to initialize authentication');
    }
  }

  // Constructor - Check if user is already logged in when app starts
  // AuthProvider() {
  //   _checkCurrentUser();
  // }
  // Update the AuthProvider constructor
  AuthProvider() {
    // Don't call _checkCurrentUser() immediately
    // Instead, call initializeAuth() from splash screen
    initializeAuth();
  }

  // Check if user is already logged in
  Future<void> _checkCurrentUser() async {
    _user = _firebaseAuth.currentUser;
    if (_user != null) {
      // If user is logged in, fetch their role from database
      await _fetchUserRole();
    }
    notifyListeners(); // Update UI
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners(); // Update UI when loading state changes
  }

  // Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners(); // Update UI when error changes
  }

  // Sign up new user with email, password and role
  Future<bool> signUp(String email, String password, String role) async {
    try {
      _setLoading(true); // Show loading indicator
      _setError(null);   // Clear any previous errors

      // Create user with Firebase Auth
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = result.user;

      if (_user != null) {
        // Store user information in Firebase Realtime Database
        await _database.child('users').child(_user!.uid).set({
          'email': email,
          'role': role, // Store the selected role (admin/customer)
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        });

        _userRole = role; // Set the role in provider
        _setLoading(false);
        return true; // Sign up successful
      }
    } catch (e) {
      _setError(e.toString()); // Show error to user
      _setLoading(false);
    }
    return false; // Sign up failed
  }

  // Sign in existing user
  Future<bool> signIn(String email, String password) async {
    try {
      _setLoading(true);
      _setError(null);

      // Sign in with Firebase Auth
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = result.user;

      if (_user != null) {
        // Fetch user role from database
        await _fetchUserRole();
        _setLoading(false);
        return true; // Sign in successful
      }
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
    return false; // Sign in failed
  }

  // Fetch user role from Firebase Database
  Future<void> _fetchUserRole() async {
    if (_user != null) {
      try {
        // Get user data from database
        DatabaseEvent event = await _database.child('users').child(_user!.uid).once();

        if (event.snapshot.exists) {
          Map<dynamic, dynamic> userData = event.snapshot.value as Map<dynamic, dynamic>;
          _userRole = userData['role']; // Get the role
        }
      } catch (e) {
        _setError('Failed to fetch user role: $e');
      }
    }
  }

  // Sign out user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      _user = null;
      _userRole = null;
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError('Failed to sign out: $e');
    }
  }

  // Clear error message
  void clearError() {
    _setError(null);
  }
}