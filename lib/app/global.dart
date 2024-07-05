import 'package:event_bus/event_bus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';


///普通事件
EventBus eventBus=new EventBus();
///可用于黏性事件
EventBus behaviorBus = EventBus.customController(BehaviorSubject());

///显示Toast消息
void showToast(String message){
  Fluttertoast.showToast(msg: message,gravity: ToastGravity.CENTER);
}

///是否debug环境
final isDebug = !inProduct();

///判断程序当前的运行环境
bool inProduct(){
  return const bool.fromEnvironment("dart.vm.product");
}


class Global{
  ///版本
  static const version = "3";//:8860
  ///key 先放本地吧
  // static const key = "52e41debbcf095616a52242f922442ce";//:
  static const key = "55b72cf8d92fa692d89bd197b05cb338";//:
  // static const Authorization = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MmU0MWRlYmJjZjA5NTYxNmE1MjI0MmY5MjI0NDJjZSIsIm5iZiI6MTcxOTkyNTUwNS4xNTgwMTksInN1YiI6IjY2ODNkNDYxODRkYzFlMzg1ZWZiMTkxMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ISus1Pt208boc6Q5Dfkr3361RiDnzoDge0yy8mQ0Vl8";//:8860
  static const Authorization = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NWI3MmNmOGQ5MmZhNjkyZDg5YmQxOTdiMDVjYjMzOCIsInN1YiI6IjY1ZWVhZmU2YTE0ZTEwMDE2MmUwMTZmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.P7C0rXOtWGZSHGvVuwq1XI_m7RmHaRz3kjuyFXBw2ng";
  static const base_url = "https://api.themoviedb.org/";//:8860

  ///图片前缀
  static const Image_Pre = "https://image.tmdb.org/t/p/$Image_min_width";
  static const Image_min_width = "w200";
  static const Image_original_width = "original";

  ///接口相关
  static const DefaultGenres = 0;

  ///数据库版本
  static const db_version = 5;
  static const db_name = "cyberbot_movies.db";

  ///搜索相关
  static const search_key_num = 10;



}








