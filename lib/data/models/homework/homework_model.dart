class HomeworkModel {
  HomeworkModel(
      {required this.username,
      required this.state,
      required this.id,
      required this.name,
      required this.avatarUrl});

  final int id;
  final String username;
  final String name;
  final String state;
  final String avatarUrl;

  factory HomeworkModel.fromJson(Map<String, dynamic> json) {
    return HomeworkModel(
        username: json["username"] as String? ?? "",
        state: json["state"] as String? ?? "",
        id: json["id"] as int? ?? 0,
        name: json["name"] as String? ?? "",
        avatarUrl: json["avatar_url"] as String? ?? "");
  }
}
