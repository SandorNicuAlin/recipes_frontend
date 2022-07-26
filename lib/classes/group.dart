import 'user.dart';

class Group {
  Group({
    required this.id,
    required this.name,
    required this.members,
    this.isAdministrator,
  });

  int id;
  String name;
  List<User> members;
  bool? isAdministrator;
}
