/// User entity representing authenticated user
class User {
  final String mobileNumber;
  final String? name;

  const User({
    required this.mobileNumber,
    this.name,
  });
}

