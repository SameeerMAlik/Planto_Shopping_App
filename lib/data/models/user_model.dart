// User Model - Data structure for user information
class UserModel {
  final String uid;
  final String email;
  final String role;
  final DateTime createdAt;
  final String? displayName;
  final String? phoneNumber;
  final String? photoUrl;

  const UserModel({
    required this.uid,
    required this.email,
    required this.role,
    required this.createdAt,
    this.displayName,
    this.phoneNumber,
    this.photoUrl,
  });

  // Create UserModel from Firebase Auth User and Database data
  factory UserModel.fromFirebase({
    required String uid,
    required String email,
    required Map<String, dynamic> userData,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      role: userData['role'] ?? 'customer',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        userData['createdAt'] ?? DateTime.now().millisecondsSinceEpoch,
      ),
      displayName: userData['displayName'],
      phoneNumber: userData['phoneNumber'],
      photoUrl: userData['photoUrl'],
    );
  }

  // Convert to JSON for Firebase Database
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
      'createdAt': createdAt.millisecondsSinceEpoch,
      if (displayName != null) 'displayName': displayName,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (photoUrl != null) 'photoUrl': photoUrl,
    };
  }

  // Check if user is admin
  bool get isAdmin => role == 'admin';

  // Check if user is customer
  bool get isCustomer => role == 'customer';

  // Copy with method for updating user data
  UserModel copyWith({
    String? displayName,
    String? phoneNumber,
    String? photoUrl,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      role: role,
      createdAt: createdAt,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;
}