class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String role;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.role = 'Mahasiswa Baru',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String? ?? 'Mahasiswa Baru',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

class AuthDatabaseService {
  static final AuthDatabaseService _instance = AuthDatabaseService._internal();
  factory AuthDatabaseService() => _instance;
  AuthDatabaseService._internal();

  // In-memory local user database table
  final Map<String, UserModel> _usersByEmail = {};

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  /// Register a new user credential into the local database
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    // Check if email already exists
    if (_usersByEmail.containsKey(normalizedEmail)) {
      return false;
    }

    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      email: normalizedEmail,
      password: password,
      role: 'Mahasiswa Baru',
    );

    _usersByEmail[normalizedEmail] = newUser;
    _currentUser = newUser;
    return true;
  }

  /// Authenticate user credentials
  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (!_usersByEmail.containsKey(normalizedEmail)) {
      return null; // User not found
    }

    final user = _usersByEmail[normalizedEmail]!;
    if (user.password != password) {
      return null; // Password mismatch
    }

    _currentUser = user;
    return user;
  }

  /// Logout current active user session
  void logout() {
    _currentUser = null;
  }

  /// Clear all registered users (for testing / reset)
  void clearDatabase() {
    _usersByEmail.clear();
    _currentUser = null;
  }
}
