import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:planto_ecommerce_app/Routes/route_names.dart';
import '../models/app_user.dart';
import '../features/auth/domain/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _repo;
  StreamSubscription<String?>? _authSub;

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // Stream for auth state changes
  Stream<AppUser?> onAuthStateChanged() {
    return _repo.onAuthStateChangedUserId().asyncMap((_) async => await _repo.getCurrentUser());
  }

  AuthProvider(this._repo) {
    _authSub = _repo.onAuthStateChangedUserId().listen((_) async {
      _currentUser = await _repo.getCurrentUser();
      notifyListeners();
    });
  }

  Future<void> signUp(String email, String password, String name, String role) async {
    _currentUser = await _repo.signUp(email: email, password: password, displayName: name, role: role);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _currentUser = await _repo.signIn(email: email, password: password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _repo.signOut();
    _currentUser = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}


