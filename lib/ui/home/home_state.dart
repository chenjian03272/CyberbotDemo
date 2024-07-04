import 'package:cyberbot_demo/app/global.dart';
import 'package:cyberbot_demo/ui/widget/load_state.dart';
import 'package:get/get.dart';

import '../../bean/movie_genres_entity.dart';
import '../../bean/movie_list_entity.dart';

///首页页面状态
class HomeState {
  HomeState() {
    ///Initialize variables
  }
  ///电影页码
  var page = 1.obs;
  ///电影列表
  var moviesList = RxList<Results>().obs;
  ///电影类型列表
  var genresList = RxList<Genres>().obs;
  ///数量
  var itemCount = 0.obs;
  ///加载状态
  var loadState = LoadState.LOADED.obs;

  var pageShowType = ShowType.WATERFALL.obs;


}
