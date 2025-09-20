import '../../../models/app_user.dart';

abstract class AuthRepository {
  Stream<String?> onAuthStateChangedUserId();
  Future<AppUser?> getCurrentUser();
  Future<AppUser> signUp({required String email, required String password, required String displayName, required String role});
  Future<AppUser> signIn({required String email, required String password});
  Future<void> signOut();
}


