
import 'package:cyberbot_demo/app/global.dart';
import 'package:cyberbot_demo/app/logger.dart';
import 'package:cyberbot_demo/app/network/http_service.dart';
import 'package:cyberbot_demo/app/res/intl.dart';
import 'package:cyberbot_demo/bean/movie_genres_entity.dart';
import 'package:cyberbot_demo/ui/widget/load_state.dart';
import 'package:get/get.dart';

import '../../bean/movie_list_entity.dart';
import '../../db/genres_provider.dart';
import '../../db/movie_list_results.dart';
import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  ///被选中的类型
  int _genresSelectIndex = Global.DefaultGenres;


  @override
  void onReady() async{
    super.onReady();

    reqMoviesGenrs();
    onRefreshList();

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
    int genres = Global.DefaultGenres;
    if(state.genresList.value.isNotEmpty){
      genres = state.genresList.value[_genresSelectIndex].id;
    }
    MovieListEntity result =  await HttpService.getAllMovies(state.page.value, genres: genres);
    if(result.results.isNotEmpty){
      var preList = RxList<Results>() ;
      preList.addAll(state.moviesList.value);

      var newList = RxList<Results>();
      for(Results item in result.results){
        if(item.posterPath != ""){
          item.posterPath = Global.Image_Pre + item.posterPath;
          newList.add(item);
        }
      }
      preList.addAll(newList);
      state.moviesList.value = preList;
      //添加到数据库
      MoviesResultProvider().inserts(newList);

      state.itemCount.value = preList.length;
      state.page.value ++ ;
      state.loadState.value = LoadState.LOADED;
      //因为海报不够一屏幕， 无法触底 加载更多， 因此自动触发(这边默认 12 个刚好一屏，  没有细算 ，大概估了一个数值)
      if(state.moviesList.value.length <= 12){
        onLoadMore();
      }
    }
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

      // GenresProvider().inserts(newList);

      state.genresList.value = newList;
    }
  }

  ///选择类型筛选
  bool checkMoviesGenres(int selectIndex){
    if(selectIndex == _genresSelectIndex){
      return false;
    }
    state.title.value = state.genresList.value[selectIndex].name;
    state.genresList.value[selectIndex].isCheck = true;
    state.genresList.value[_genresSelectIndex].isCheck = false;
    _genresSelectIndex = selectIndex;
    //重新请求数据
    onRefreshList();
    return true;
  }
  ///获取当前类型筛选位置
  int getSelectMoviesGenresIndex(){
    return _genresSelectIndex;
  }

}
