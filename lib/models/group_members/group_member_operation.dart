import 'package:expense_tracker/database/db_repo.dart';
import 'package:expense_tracker/models/group_members/group_member_model.dart';
import 'package:expense_tracker/models/members/member_model.dart' as model;

class GroupMemberOperation {
  DbRepo dbRepo = DbRepo.instance;

  Future<GroupMember> create(GroupMember groupMember) async {
    final db = await dbRepo.database;

    final id = await db.insert(table, groupMember.toJson());
    return groupMember.copy(id: id);
  }

  Future<List<model.Member>> getMembersInGroup(int groupId) async {
    final db = await dbRepo.database;

    final maps = await db.rawQuery(
      "SELECT members.id, members.name FROM group_members LEFT JOIN members ON group_members.memberId = members.id WHERE groupId = ?",
      [groupId],
    );

    return model.Member.fromListJson(maps);
  }

  Future<GroupMember?> get(
      {required int groupId, required int memberId}) async {
    final db = await dbRepo.database;

    final maps = await db.query(table,
        where:
            '${GroupMemberColumns.groupId} = ? AND ${GroupMemberColumns.memberId} = ?',
        whereArgs: [groupId, memberId]);

    if (maps.isNotEmpty) {
      return GroupMember.fromJson(maps.first);
    } else {
      return null;
    }
  }
}
