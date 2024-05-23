import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static final _databaseName = "todo.db";
  static final _databaseVersion = 1;

  static final table = "todo";

  static final columnId = 'id';
  static final columnTitle = 'title';

  DatabaseHelper._privateConstructor() {
    _database = _initDatabase() as Database;
  }
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  late final Database _database;

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> todo) async {
    return await _database.insert(table, todo);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _database.query(table, orderBy: "$columnId DESC");
  }

  Future<int> delete(int id) async {
    return await _database.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> clearTable() async {
    return await _database.delete(table);
  }
}
