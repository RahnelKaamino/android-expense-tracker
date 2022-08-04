final String table = 'members';

class Member {
  final int? id;
  final String name;

  Member({
    this.id,
    required this.name,
  });

  Member copy({
    int? id,
    String? name,
  }) =>
      Member(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, Object?> toJson() => {
        "id": id,
        "name": name,
      };

  static Member fromJson(Map<String, Object?> json) => Member(
        id: json["id"] as int?,
        name: json["name"] as String,
      );

  static List<Member> fromListJson(List<Map<String, Object?>> jsons) {
    List<Member> container = [];

    for (final json in jsons) {
      container.add(Member.fromJson(json));
    }

    return container;
  }
}

class MemberColumns {
  static final List<String> values = [id, name];

  static final String id = "id";
  static final String name = 'name';
}
