import 'package:shared_preferences/shared_preferences.dart';

/// 应用内数据缓存处理
class AppData {
  // static Box? box;
  static SharedPreferences? prefs;

  static Future<bool> initData() async {
    prefs = await SharedPreferences.getInstance();
    // print("初始化完成${ DateTime.now().toString()} ${prefs!=null}");
    return Future.value(prefs!=null);
  }

  static void saveLocaleIndex(int index) async {
    prefs?.setInt("locale_index", index);
  }

  static int queryLocaleIndex() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs?.getInt("locale_index") == null ? 1 : prefs!.getInt("locale_index")!;
  }


}
