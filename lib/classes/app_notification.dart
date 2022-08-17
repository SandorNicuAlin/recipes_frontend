class AppNotification {
  AppNotification({
    required this.id,
    required this.type,
    required this.text,
    required this.seen,
  });

  int id;
  String type;
  String text;
  bool seen;
}
