import 'package:mood_tracker/mood.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {

  static const String createMoodsTable = '''
    CREATE TABLE moods (
      day INTEGER NOT NULL,
      month INTEGER NOT NULL,
      year INTEGER NOT NULL,
      mood TEXT NOT NULL,
      description TEXT,
      PRIMARY KEY (day, month, year)
    )
  ''';

  static const String getMonthMoods = '''
    SELECT * FROM moods
    WHERE year = ? AND month = ?
    ORDER BY year DESC, month DESC, day DESC
  ''';


  DbManager._() : _db = _openDb();


  static DbManager? _manager;


  final Future<Database> _db;


  static DbManager get manager {
    _manager ??= DbManager._();
    return _manager!;
  }


  static Future<Database> _openDb() async {

    return openDatabase(
      join(
        await getDatabasesPath(),
        'mood.db',
      ),
      onCreate: (db, version) => db.execute(createMoodsTable),
      version: 10,
    );
  }


  Future<void> insertMood(Mood mood) async {

    final Database db = await _db;
    await db.insert(
      'moods', 
      mood.toMap(),
    );
  }


  Future<List<Map<String, Object?>>> getMoods(int year, int month) async {

    final Database db = await _db;
    return db.rawQuery(getMonthMoods, [year, month]);
  }
}