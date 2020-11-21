import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'objects/habit.dart';

class DbHelper {
  Future<Database> database;
  final String dbName = "habits";

  DbHelper() {
    fetchDatabase();
  }

  void fetchDatabase() async {
    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'habits_database.db'),

      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE habits (id INTEGER PRIMARY KEY, name TEXT, days INTEGER,objective INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertHabit(Habit habit) async {
    // Get a reference to the database.
    final Database db =
        await Future.delayed(Duration(milliseconds: 500), () => database);

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      dbName,
      habit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Habit>> getHabits() async {
    final Database db =
        await Future.delayed(Duration(seconds: 1), () => database);

    final List<Map<String, dynamic>> maps = await db.query(dbName);

    return List.generate(
        maps.length,
        (i) => Habit(
            id: maps[i]['id'],
            name: maps[i]['name'],
            days: maps[i]['days'],
            objective: maps[i]['objective']));
  }

  Future<void> updateHabit(Habit habit) async {
    final Database db =
        await Future.delayed(Duration(milliseconds: 500), () => database);
    await db
        .update(dbName, habit.toMap(), where: "id = ?", whereArgs: [habit.id]);
  }

  Future<void> deleteHabit(Habit habit) async {
    final Database db = await database;
    await db.delete(dbName, where: "id = ?", whereArgs: [habit.id]);
  }
}
