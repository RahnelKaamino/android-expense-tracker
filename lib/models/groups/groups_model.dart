final String table = 'groups';

class Group {
  final int? id;
  final int groupSize;

  Group({
    this.id,
    required this.groupSize,
  });

  Group copy({
    int? id,
    int? groupSize,
  }) =>
      Group(
        id: id ?? this.id,
        groupSize: groupSize ?? this.groupSize,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'groupSize': groupSize,
      };

  static Group fromJson(Map<String, Object?> json) => Group(
        id: json['id'] as int?,
        groupSize: json['groupSize'] as int,
      );
}

class GroupColumns {
  static final List<String> values = [id, groupSize];

  static final String id = 'id';
  static final String groupSize = 'groupSize';
}
