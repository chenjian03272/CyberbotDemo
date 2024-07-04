// import 'dart:io';
//
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBManager {
//   /// 数据库名
//   final String _dbName = "cyberbot";
//   /// 数据库版本
//   final int _version = 1;
//   static final DBManager _instance = DBManager._();
//   factory DBManager() {
//     return _instance;
//   }
//
//   DBManager._();
//   static Database? _db;
//   Future<Database> get db async {
//     return _db ??= await _initDB();
//   }
//
//   /// 初始化数据库
//   Future<Database> _initDB() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, _dbName);
//
//     return await openDatabase(
//       path,
//       version: _version,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );
//   }
//
//   /// 创建表
//   Future _onCreate(Database db, int version) async {
//     const String sql = """
//     CREATE TABLE User(
//       id INTEGER primary key AUTOINCREMENT,
//       name TEXT,
//       pwd TEXT,
//       power INTEGER
//     )
//     """;
//     return await db.execute(sql);
//   }
//
//   /// 更新表
//   Future _onUpgrade(Database db, int oldVersion, int newVersion) async {}
//
//   /// 使用SQL保存数据
//   Future saveDataBySQL(User user) async {
//     const String sql = """
//     INSERT INTO User(name,pwd,power) values(?,?,?)
//     """;
//     Database database = await db;
//     return await database.rawInsert(sql, [user.name, user.pwd, user.power]);
//   }
//
//   /// 查询全部数据
//   Future<List<User>?> findAll() async {
//     Database? database = await db;
//     List<Map<String, Object?>> result = await database.query("User");
//     if (result.isNotEmpty) {
//       return result.map((e) => User.fromJson(e)).toList();
//     } else {
//       return [];
//     }
//   }
//
//   /**
//    * 条件查询
//    *  ==》该方法主要用于用户登录，通过传入用户名和密码来查询数据库
//    * 用法：直接在登录按钮里面直接调用：DBManager().find(_username, _password, context);
//    */
//   Future<List<User>?> find(
//       String name, String password, BuildContext context) async {
//     Database database = await db;
//     List<Map<String, Object?>> result = await database.query("User",
//         where: "name =? and pwd=? ", whereArgs: [name, password]);
//
//     if (result.isNotEmpty) {
//       okToast("登录成功");
//       // GoRouter.of(context).go('/main'); //登录成功跳转的页面
//     } else {
//       errorToast("用户名或者密码错误");
//     }
//     return null;
//   }
//
//   /**
//    * 条件查询
//    * ==》该方法用于默然一个管理员账号，通过登录的时候判断登录的是否为管理员
//    * 用法：直接在登录按钮里面直接调用：DBManager().find(_username, _password, context);
//    */
//   Future<List<User>?> LoginQuery(
//       String name, String password, BuildContext context) async {
//     String username = 'admin';
//     String pwd = 'sk123';
//     Database database = await db;
//     List<Map<String, Object?>> result = await database.query("User",
//         where: "name =? and pwd=? ", whereArgs: [name, password]);
//
//     if (result.isNotEmpty) {
//       if (name == username && password == pwd) {
//         // GoRouter.of(context).go('/main'); //查询结果为管理员跳转的页面
//         print("管理员界面");
//       } else {
//         // GoRouter.of(context).go('/main'); //查询结果为用户跳转的页面
//         print("测试用户界面");
//       }
//     }
//     return null;
//   }
//
//   /**
//    * 添加默认账户表单
//    * ==>sqlite存储的本地文件，当用户使用app的时候是本地文件是没有数据的，所以我们要在新用户登录的时候创建一个默认本地账户表
//    *  用法: 在登录按钮里面直接调用: DBManager().insertUser();
//    */
//   Future<int?> insertUser() async {
//     Database? database = await db;
//     List<Map<String, Object?>> result = await database.query("User");
//     if (result.isEmpty) {
//       var admin = User(
//         name: 'admin',
//         pwd: 'admin123',
//         power: 1,
//       );
//       var test = User(
//         name: 'test',
//         pwd: 'test123',
//         power: 1,
//       );
//       await DBManager().saveDataBySQL(admin);
//       await DBManager().saveDataBySQL(test);
//     } else {
//       return null;
//     }
//     return null;
//   }
//
//   /**
//    * 修改表中的某一项的值为自定义的默认值
//    */
//   Future<int> update(User user) async {
//     Database database = await db;
//     user.pwd = '123456'; //修改表中password字段的默认值为 123456
//     int count = await database
//         .update("User", user.toJson(), where: "id=?", whereArgs: [user.id]);
//     return count;
//   }
//
//   /**
//    * 删除操作
//    * 根据id删除
//    */
//   Future<int> delete(int id) async {
//     Database database = await db;
//     int count = await database.delete("User", where: "id=?", whereArgs: [id]);
//     return count;
//   }
//
//   /**
//    * 删除全部数据
//    */
//   Future<int> deleteAll() async {
//     Database database = await db;
//     int count = await database.delete("User");
//     return count;
//   }
// }
