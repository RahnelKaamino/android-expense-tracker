final String table = "group_members";

class GroupMember {
  final int? id;
  final int groupId;
  final int memberId;

  GroupMember({
    this.id,
    required this.groupId,
    required this.memberId,
  });

  GroupMember copy({
    int? id,
    int? groupId,
    int? memberId,
  }) =>
      GroupMember(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        memberId: memberId ?? this.memberId,
      );

  Map<String, Object?> toJson() => {
        "id": id,
        "groupId": groupId,
        "memberId": memberId,
      };

  static GroupMember fromJson(Map<String, Object?> json) => GroupMember(
      id: json["id"] as int?,
      groupId: json["groupId"] as int,
      memberId: json["memberId"] as int);
}

class GroupMemberColumns {
  static final List<String> values = [id, groupId, memberId];

  static final String id = 'id';
  static final String groupId = 'groupId';
  static final String memberId = "memberId";
}
