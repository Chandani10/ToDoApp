import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/model/task_data.dart';

class DatabaseHelper {
  static const _databaseName = "todo.db";
  static const _databaseVersion = 1;
  static const table = "todo";
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnPriorityLevel = 'priorityLevel';
  static const columnDueDate = 'dueDate';




  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }


  Future<Batch> get batch async {
    if (_database != null) {
      return _database!.batch();
    }
    // if _database is null we instantiate it
    _database = await _initDatabase();
    return _database!.batch();
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnDueDate TEXT NOT NULL,
            $columnPriorityLevel INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insert(TaskData todo) async {
    Database db = await database;
    var res = await db.insert(table, todo.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await database;
    var res = await db.query(table, orderBy: "$columnId DESC");
    return res;
  }


  Future<int> delete(int id) async {
    Database db = await database;
    int response = await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
    if(response != 0) {
      return response;
    }else{
      return 0;
    }
  }

  Future<int?> update(TaskData? todo) async{
    var db = await database;
    if (todo?.toMap() != null){
      var response = await db.update(table, todo!.toMap(), where: "id = ?", whereArgs: [todo.id]);
      return response;
    }
    return null;
  }

  Future<List<Map<String, Object?>>> clearTable() async {
    Database db = await database;
    return await db.rawQuery("DELETE FROM $table");
  }
}
