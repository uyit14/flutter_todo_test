import 'dart:async';
import 'package:flutter_todo_test/data/common/models/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static const String DB_NAME = 'todo.db';
  static const String TABLE_NAME = 'todo';
  static const String COLUMN_ID = '_id';
  static const String COLUMN_TITLE = 'title';
  static const String COLUMN_CONTENT = 'content';
  static const String COLUMN_COMPLETE = 'complete';

  static final DBProvider _singleton = DBProvider._internal();

  factory DBProvider() {
    return _singleton;
  }

  DBProvider._internal();

  static Database _db;

  static Future<Database> _getDatabase() async {
    if (_db != null) return _db;
    _db = await _initDB();
    return _db;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, DB_NAME);

    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  static void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $TABLE_NAME($COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_TITLE TEXT, '
            '$COLUMN_CONTENT TEXT, $COLUMN_COMPLETE INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    final db = await _getDatabase();
    var result = await db.query(TABLE_NAME, orderBy: '$COLUMN_ID DESC');
    return result;
  }

  Future<List<TodoModel>> getTodoList() async {
    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;

    List<TodoModel> todoList = List<TodoModel>();
    for (int i = 0; i < count; i++) {
      todoList.add(TodoModel.fromMap(todoMapList[i]));
    }
    return todoList;
  }

  Future<List<Map<String, dynamic>>> getCompleteTodoMapList() async {
    final db = await _getDatabase();
    var result = await db.query(TABLE_NAME, orderBy: '$COLUMN_ID DESC', where: '$COLUMN_COMPLETE = 1');
    return result;
  }

  Future<List<TodoModel>> getCompleteTodoList() async {
    var todoMapList = await getCompleteTodoMapList();
    int count = todoMapList.length;

    List<TodoModel> todoList = List<TodoModel>();
    for (int i = 0; i < count; i++) {
      todoList.add(TodoModel.fromMap(todoMapList[i]));
    }
    return todoList;
  }

  Future<List<Map<String, dynamic>>> getInCompleteTodoMapList() async {
    final db = await _getDatabase();
    var result = await db.query(TABLE_NAME, orderBy: '$COLUMN_ID DESC', where: '$COLUMN_COMPLETE = 0');
    return result;
  }

  Future<List<TodoModel>> getInCompleteTodoList() async {
    var todoMapList = await getInCompleteTodoMapList();
    int count = todoMapList.length;

    List<TodoModel> todoList = List<TodoModel>();
    for (int i = 0; i < count; i++) {
      todoList.add(TodoModel.fromMap(todoMapList[i]));
    }
    return todoList;
  }

  Future<int> insertTodo(TodoModel todo) async {
    final db = await _getDatabase();
    var result = await db.insert(TABLE_NAME, todo.toMap());
    return result;
  }

  Future<int> updateTodo(TodoModel todo) async {
    final db = await _getDatabase();
    var result = await db.update(TABLE_NAME, todo.toMap(),
        where: '$COLUMN_ID = ?', whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    final db = await _getDatabase();
    var result =
    await db.rawDelete('DELETE FROM $TABLE_NAME where $COLUMN_ID = $id');
    return result;
  }
}