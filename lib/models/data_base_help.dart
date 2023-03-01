import 'package:database_test_2/models/to_do_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DataHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'ProductDB.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);

    return db;
  }

  _createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, description TEXT)');
  }

  //INSERT A NEW PRODUCT
  Future<ToDoModel> insertProduct(ToDoModel toDoModel) async {
    var dbClient = _db;
    dbClient?.insert(
      'products',
      toDoModel.toMap(),
    );
    return toDoModel;
  }

  //LIST OF PRODUCTS
  Future<List<ToDoModel>> getAllProducts() async {
    await db;
    final List<Map<String, dynamic>> queryResult =
        await _db!.rawQuery('SELECT * FROM products');
    return queryResult.map((e) => ToDoModel.fromMap(e)).toList();
  }

  //DELETE A PRODUCT
  Future<int> deleteProduct(int id) async {
    var dbClient = _db;
    return await dbClient!.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  //UPDATE A PRODUCT
  Future<int> updateProduct(ToDoModel toDoModel) async {
    var dbClient = _db;
    return await dbClient!.update('products', toDoModel.toMap(),
        where: 'id = ?',
        whereArgs: [toDoModel.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
