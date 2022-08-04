import 'package:expense_tracker/database/db_repo.dart';
import 'package:expense_tracker/models/members/member_model.dart';

class MemberOperation {
  DbRepo dbRepo = DbRepo.instance;

  Future<Member> create(Member member) async {
    final db = await dbRepo.database;

    final id = await db.insert(table, member.toJson());
    return member.copy(id: id);
  }
}
