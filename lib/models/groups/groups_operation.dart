import 'package:expense_tracker/database/db_repo.dart';
import 'package:expense_tracker/models/expenses/expense_model.dart' as expense;
import 'package:expense_tracker/models/group_members/group_member_model.dart'
    as groupMember;
import 'package:expense_tracker/models/groups/groups_model.dart';

class GroupOperation {
  DbRepo dbRepo = DbRepo.instance;

  Future<Group> createGroup(Group group) async {
    final db = await dbRepo.database;

    final id = await db.insert(table, group.toJson());
    return group.copy(id: id);
  }

  Future<Group?> readGroup(int id) async {
    final db = await dbRepo.database;

    final maps = await db.query(
      table,
      columns: GroupColumns.values,
      where: '${GroupColumns.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Group.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<num> getGroupExpenses(int groupId) async {
    final db = await dbRepo.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery("""
        SELECT e.expense FROM $table as g 
        LEFT JOIN ${groupMember.table} as gm ON g.${GroupColumns.id} = gm.${groupMember.GroupMemberColumns.groupId}
        LEFT JOIN ${expense.table} as e ON e.${expense.ExpenseColumns.groupMemberId} = gm.${groupMember.GroupMemberColumns.id}
        WHERE g.${GroupColumns.id} = ?;
        """, [groupId]);

    if (maps.isNotEmpty) {
      num count = 0;
      for (final map in maps) {
        count = count + (map["expense"] ?? 0);
      }

      return count;
    } else {
      return 0;
    }
  }
}
