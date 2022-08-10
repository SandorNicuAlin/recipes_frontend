class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    this.isAdministrator,
  });

  int id;
  String username;
  String email;
  String phone;
  bool? isAdministrator;
}
