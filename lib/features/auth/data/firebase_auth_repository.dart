import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../models/app_user.dart';
import '../domain/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  @override
  Stream<String?> onAuthStateChangedUserId() => _auth.authStateChanges().map((u) => u?.uid);

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final snapshot = await _db.child('users/${user.uid}').get();
    if (!snapshot.exists) return null;
    return AppUser.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
  }

  @override
  Future<AppUser> signUp({required String email, required String password, required String displayName, required String role}) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await cred.user!.updateDisplayName(displayName);
    final appUser = AppUser(uid: cred.user!.uid, email: email, displayName: displayName, role: role);
    await _db.child('users/${appUser.uid}').set(appUser.toJson());
    return appUser;
  }

  @override
  Future<AppUser> signIn({required String email, required String password}) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final snapshot = await _db.child('users/${cred.user!.uid}').get();
    
    if (!snapshot.exists) {
      final appUser = AppUser(
        uid: cred.user!.uid, 
        email: cred.user!.email ?? email, 
        displayName: cred.user!.displayName ?? 'User', 
        role: 'customer'
      );
      await _db.child('users/${appUser.uid}').set(appUser.toJson());
      return appUser;
    }
    
    return AppUser.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}


