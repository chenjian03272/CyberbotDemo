
import 'package:cyberbot_demo/app/global.dart';
import 'package:cyberbot_demo/app/logger.dart';
import 'package:cyberbot_demo/app/network/http_service.dart';
import 'package:cyberbot_demo/app/res/intl.dart';
import 'package:cyberbot_demo/bean/movie_genres_entity.dart';
import 'package:cyberbot_demo/ui/widget/load_state.dart';
import 'package:get/get.dart';

import '../../bean/movie_list_entity.dart';
import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  ///被选中的类型
  int _genresSelectIndex = 0;


  @override
  void onReady() {
    super.onReady();

    onRefreshList();
    reqMoviesGenrs();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///刷新页面
  void onRefreshList(){
    state.page.value = 1;
    state.itemCount.value = 0;
    state.moviesList.value.clear();
    _reqMoviesList();
  }
  ///加载更多
  void onLoadMore(){
    state.loadState.value = LoadState.LOADING;
    _reqMoviesList();
  }

  ///请求电影列表
  void _reqMoviesList() async{
    MovieListEntity result =  await HttpService.getMoviesList(state.page.value);
    if(result.results.isNotEmpty){
      var preList = RxList<Results>() ;
      preList.addAll(state.moviesList.value);
      for(Results item in result.results){
        if(item.posterPath != ""){
          item.posterPath = Global.Image_Pre + item.posterPath;
          preList.add(item);
        }
      }
      state.moviesList.value = preList;
      state.itemCount.value = preList.length;
      state.page.value ++ ;
      state.loadState.value = LoadState.LOADED;
    }
    // loggerE(result.results);

  }

  void changeShowType(){
    loggerE("type:  ${state.pageShowType.value}");
    if(state.pageShowType.value == ShowType.WATERFALL){
      state.pageShowType.value = ShowType.PAGEVIEW;
    }else{
      state.pageShowType.value = ShowType.WATERFALL;
    }
  }

  ///获取原图
  String getOriImagePath(int index){
    String path = state.moviesList.value[index].posterPath;
    path = path.replaceAll(Global.Image_min_width, Global.Image_original_width);
    return path;
  }
  ///网络请求电影类型列表
  void reqMoviesGenrs() async{
    MovieGenresEntity genres = await HttpService.getGenresList();
    if(genres.genres.isNotEmpty){
      var newList = RxList<Genres>();
      Genres all = Genres(0, Intl().allGenres);
      _genresSelectIndex = 0;
      all.isCheck = true;
      newList.add(all);
      newList.addAll(genres.genres);
      state.genresList.value = newList;
    }
  }

  ///选择类型筛选
  bool checkMoviesGenres(int selectIndex){
    if(selectIndex == _genresSelectIndex){
      return false;
    }
    state.genresList.value[selectIndex].isCheck = true;
    state.genresList.value[_genresSelectIndex].isCheck = false;
    _genresSelectIndex = selectIndex;
    return true;
  }
  ///获取当前类型筛选位置
  int getSelectMoviesGenresIndex(){
    return _genresSelectIndex;
  }

}
