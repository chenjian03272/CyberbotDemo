import 'package:cyberbot_demo/bean/movie_list_entity.dart';
import 'package:get/get.dart';

import '../../app/global.dart';
import 'detail_state.dart';

class DetailLogic extends GetxController {
  final DetailState state = DetailState();


  ///电影Id
  int movieId = 0;

  @override
  void onReady() {
    super.onReady();

    // printInfo(info: "传递过来的参数: ${Get.arguments.toString()}");
    movieId = Get.arguments["id"];
  }

  Results? getSelectMoviesItem(){
    Map<String, String?> map = Get.parameters;
    Results results = Results.fromStringJson(map);
    return results;
  }



  ///hero tag
  String getImageTag(){
    // loggerE("++tag======:  ${Get.arguments["id"]}");
    return "${Get.arguments["id"]}";
  }
  String getDescTag(){
    // loggerE("++tag======:  ${Get.arguments["id"]}");
    return "${Get.arguments["id"]}-${Get.arguments["index"]}";
  }
  ///获取列表传递过来的缩略图
  String getImagePath(){
    return Get.arguments["posterPath"];
  }
  ///获取原图
  String getOriImagePath(){
    String path = Get.arguments["posterPath"];
    path = path.replaceAll(Global.Image_min_width, Global.Image_original_width);
    return path;
  }



}
