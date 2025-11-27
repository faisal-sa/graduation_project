class User {
  final String id;
  final String email;
  final String? phone;
  final String role;

  const User({
    required this.id,
    required this.email,
    this.phone,
    required this.role,
  });
}
