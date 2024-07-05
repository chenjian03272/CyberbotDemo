import 'dart:async';

import 'package:cyberbot_demo/app/global.dart';
import 'package:cyberbot_demo/db/genres_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../app/logger.dart';
import 'movie_list_results.dart';

class SqfliteHelper {
  late Database database;

  //饿汉式单例
  static SqfliteHelper _instance = SqfliteHelper._();

  //工厂模式，单例公开访问点
  factory SqfliteHelper() => _getInstance();

  //私有构造
  SqfliteHelper._();

  static SqfliteHelper _getInstance() {
    return _instance;
  }

  Future<Database> init() async {
    String path = await getDatabasesPath();
    path = '$path/${Global.db_name}';
    loggerE('路径:$path');
    database = await openDatabase(
      path,
      version: Global.db_version,
      singleInstance: false,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
    return database;
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();
    if (oldVersion == 1) {
      batch.execute('alter table ta_person add fire text');
    } else if (oldVersion == 2) {
      batch.execute('alter table ta_person add water text');
    } else if (oldVersion == 3) {}
    oldVersion++;
    //升级后版本还低于当前版本，继续递归升级
    if (oldVersion < newVersion) {
      _onUpgrade(db, oldVersion, newVersion);
    }
    await batch.commit();
  }

  FutureOr<void> _onCreate(Database db, int version) async {

    db.execute(MoviesResultProvider.createSql);
    //类别数据
    db.execute(GenresProvider.createSql);
  }

  FutureOr<void> _onDowngrade(
      Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();

    await batch.commit();
  }

  Future<bool> isTableExists(String table) async {
    String sql =
        "select * from Sqlite_master where type='table' and name= '$table'";
    var result = await database.rawQuery(sql);
    return result.isNotEmpty;
  }

  tableName() async {
    String sql = "select * from Sqlite_master where type='table' ";
    var result = await database.rawQuery(sql);
    result.forEach((element) {
      print(element.toString());
    });
  }
}