import 'package:expense_tracker/constants/trips/trip_constants.dart';
import 'package:expense_tracker/database/db_repo.dart';
import 'package:expense_tracker/models/trips/trip_model.dart';

class TripOperation {
  DbRepo dbRepo = DbRepo.instance;

  Future<Trip> create(Trip trip) async {
    final db = await dbRepo.database;

    final id = await db.insert(table, trip.toJson());
    return trip.copy(id: id);
  }

  Future<Trip?> findActive() async {
    final db = await dbRepo.database;

    final maps = await db.query(
      table,
      columns: TripColumns.values,
      where: '${TripColumns.status} = ?',
      whereArgs: [IN_PROGRESS],
    );

    if (maps.isNotEmpty) {
      return Trip.fromJson(maps.first);
    } else {
      return null;
    }
  }

  void endTrip(Trip trip) async {
    final db = await dbRepo.database;

    Trip newTrip = trip.copy(status: 'FINISH');

    await db.update(
      table,
      newTrip.toJson(),
      where: '${TripColumns.id} = ?',
      whereArgs: [trip.id as int],
    );
  }
}
