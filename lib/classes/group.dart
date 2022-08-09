import 'user.dart';

class Group {
  Group({
    required this.id,
    required this.name,
    required this.members,
  });

  int id;
  String name;
  List<User> members;
}
