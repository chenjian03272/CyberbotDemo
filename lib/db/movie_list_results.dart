


import 'package:cyberbot_demo/bean/movie_list_entity.dart';
import 'package:cyberbot_demo/db/sqflite_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../app/global.dart';

const String _id = "id";
const String _title = "title";
const String _originalTitle = "original_title";
const String _overview = "overview";
const String _posterPath = "poster_path";
const String _releaseDate = "release_date";
const String _genreIds = "genre_ids";
const String _originalLanguage = "original_language";
const String _adult = "adult";
const String _popularity = "popularity";
const String _video = "video";
const String _voteAverage = "vote_average";
const String _voteCount = "vote_count";

///电影数据表
class MoviesResultProvider{

  late Database _database;
  static const String _table = 'my_movies';
  static String createSql =
      'CREATE TABLE $_table ($_adult INTEGER, $_genreIds TEXT, $_id INTEGER PRIMARY KEY, $_originalLanguage TEXT, $_originalTitle TEXT, $_overview TEXT, $_popularity TEXT, $_posterPath TEXT, $_releaseDate TEXT, $_title TEXT, '
      '$_video INTEGER, $_voteAverage TEXT, $_voteCount TEXT)';

  MoviesResultProvider() {
    _database = SqfliteHelper().database;
  }

  Future insert(Results results) async {
    return await _database.insert(_table, results.toSqlJson());
  }

  Future inserts(List<Results> results) async {
    Batch batch = _database.batch();
    for(Results result in results){
      batch.insert(_table, result.toSqlJson());
    }
    return await batch.commit();
  }

  Future<Results?> query(int id) async {
    List<Map<String, dynamic>> maps = await _database.query(
      _table,
      columns: [_id, _title, _originalTitle, _overview, _posterPath, _releaseDate, _genreIds, _originalLanguage],
      where: '$_id=?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.length == 1) {
      return Results.fromSqlJson(maps.first);
    } else {
      return null;
    }
  }
  ///模糊匹配名字
  Future<List<Results>?> queryName(String searchKey) async {
    List<Map<String, dynamic>> maps = await _database.query(
      _table,
      columns: [_id, _title, _originalTitle, _overview, _posterPath, _releaseDate, _genreIds, _originalLanguage],
      where: "$_title  LIKE ?",
      whereArgs: ['%$searchKey%'],
      limit: 1,
    );
    List<Results> list = [];
    for(Map<String, dynamic> map in maps){
      list.add(Results.fromSqlJson(map));
    }
    return list;
  }

  Future<List<Results>> queryAll() async {
    List<Map<String, dynamic>> maps = await _database.query(_table);
    List<Results> list = [];
    for(Map<String, dynamic> map in maps){
      list.add(Results.fromSqlJson(map));
    }
    return list;
  }

  Future delete(int id) async {
    return await _database.delete(
      _table,
      where: '$_id=?',
      whereArgs: [id],
    );
  }

  Future update(Results article) async {
    return await _database.update(
      _table,
      article.toSqlJson(),
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