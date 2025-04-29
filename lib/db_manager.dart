import 'package:flutter/material.dart';
import 'package:mood_tracker/mood.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {
  static final Future<Database> _db = _openDb();

  static Future<Database> _openDb() async {
    
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(
        await getDatabasesPath(),
        'mood.db',
      ),
      onCreate: (db, version) => _createDb(db), version: 1,
    );
  }

  static void _createDb(Database db) {
    db.execute(
      '''CREATE TABLE moods (
      day INTEGER NOT NULL, 
      month INTEGER NOT NULL, 
      year INTEGER NOT NULL, 
      mood INTEGER NOT NULL, 
      description TEXT, 
      PRIMARY KEY (day, month, year)
      )''',
    );
  }

  static void insertMood(Mood mood) async {
    final Database db = await _db;
    db.insert(
      'moods',
      mood.toMap(),
    );
  }

  static Future<List<Mood>> moods() async {
    final Database db = await _db;
    final List<Map<String, Object?>> moodMaps = await db.query('moods');

    return [
      for (final {'day': day as int, 
      'month': month as int, 
      'year': year as int, 
      'mood': mood as int, 
      'description': description as String}
      in moodMaps)
        Mood(day: day, month: month, year: year, mood: mood, description: description),
    ];
  }

  static void test() {
    print('done');
  }
}