import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('2048.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE HighScores(
      id INTEGER PRIMARY KEY,
      score INTEGER
    )
    ''');
    await db.insert('HighScores', {'id': 1, 'score': 0});
  }

  Future<int?> getHighScore() async {
    final db = await instance.database;
    final result =
        await db.query('HighScores', where: 'id = ?', whereArgs: [1]);
    return result.isNotEmpty ? result.first['score'] as int? : null;
  }

  Future<void> updateHighScore(int newScore) async {
    final db = await instance.database;
    await db.update('HighScores', {'score': newScore},
        where: 'id = ?', whereArgs: [1]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
