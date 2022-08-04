import 'package:expense_tracker/database/db_repo.dart';
import 'package:expense_tracker/models/expenses/expense_model.dart';

class ExpenseOperation {
  DbRepo dbRepo = DbRepo.instance;

  Future<Expense> create(Expense expense) async {
    final db = await dbRepo.database;

    final id = await db.insert(table, expense.toJson());
    return expense.copy(id: id);
  }

  Future<List<Expense>> getMemberExpenses(int groupMemberId) async {
    final db = await dbRepo.database;

    final maps = await db.query(
      table,
      where: '${ExpenseColumns.groupMemberId} = ?',
      whereArgs: [groupMemberId],
    );

    if (maps.isNotEmpty) {
      return Expense.fromListJson(maps);
    } else {
      return [];
    }
  }
}
