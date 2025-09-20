class AppUser {
  final String uid;
  final String email;
  final String displayName;
  final String role; // 'admin' or 'customer'

  AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role,
    };
  }

  factory AppUser.fromJson(Map<dynamic, dynamic> json) {
    return AppUser(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: (json['displayName'] ?? '') as String,
      role: (json['role'] ?? 'customer') as String,
    );
  }
}


