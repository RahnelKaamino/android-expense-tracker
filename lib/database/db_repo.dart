import 'package:expense_tracker/database/create_db.dart';
import 'package:expense_tracker/database/create_expense.dart';
import 'package:expense_tracker/database/create_group_members.dart';
import 'package:expense_tracker/database/create_members.dart';
import 'package:expense_tracker/database/create_trip.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbRepo {
  DbRepo._init();
  static final DbRepo instance = DbRepo._init();

  final _dbName = 'expense_tracker.db';
  final _dbVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDb();
    }
    return _database!;
  }

  _initDb() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDb,
    );
  }

  Future _createDb(Database db, int version) async {
    await db.execute(createDb);
    await db.execute(createTrip);
    await db.execute(createMembers);
    await db.execute(createGroupMembers);
    await db.execute(createExpense);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
