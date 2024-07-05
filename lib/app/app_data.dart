import 'package:shared_preferences/shared_preferences.dart';

/// 应用内数据缓存处理
class AppData {
  // static Box? box;
  static SharedPreferences? prefs;

  static const String _search_words = "search_words";

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

  ///保存搜索关键字
  static void saveSearchWords(List<String> words)async{
    prefs?.setStringList(_search_words, words);
  }

  ///提取搜索关键字
  static List<String> getSearchWords(){
    return prefs?.getStringList(_search_words)??<String>[];
  }



}
