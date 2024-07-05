
import 'package:sqflite/sqflite.dart';

import '../app/global.dart';
import '../bean/movie_genres_entity.dart';
import 'sqflite_helper.dart';

const String _id = 'id';
const String _name = 'name';

///类别数据表
class GenresProvider {
  late Database _database;
  static const String _table = 'my_genres';
  static String createSql =
      'CREATE TABLE $_table ($_id INTEGER PRIMARY KEY, $_name TEXT)';

  GenresProvider() {
    _database = SqfliteHelper().database;
  }

  Future insert(Genres person) async {
    return await _database.insert(_table, person.toJson());
  }

  Future inserts(List<Genres> persons) async {
    Batch batch = _database.batch();
    persons.forEach((element) {
      batch.insert(_table, element.toJson());
      // print('${DateTime.now()}--${element.toJson()}');
    });
    return await batch.commit();
  }

  Future<Genres?> query(int id) async {
    List<Map<String, dynamic>> maps = await _database.query(
      _table,
      columns: [_id, _name],
      where: '$_id=?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.length == 1) {
      return Genres.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Genres>> queryAll() async {
    List<Map<String, dynamic>> maps = await _database.query(_table);
    List<Genres> persons = [];
    maps.forEach((element) {
      persons.add(Genres.fromJson(element));
    });
    return persons;
  }

  Future delete(int id) async {
    return await _database.delete(
      _table,
      where: '$_id=?',
      whereArgs: [id],
    );
  }

  Future update(Genres person) async {
    return await _database.update(
      _table,
      person.toJson(),
    );
  }

  Future close() async {
    return await _database.close();
  }

  Future drop() async {
    String path = await getDatabasesPath();
    path = '$path/${Global.db_name}';
    return await deleteDatabase(path);
  }

  Future clear() async {
    await _database.delete(_table);
  }
}