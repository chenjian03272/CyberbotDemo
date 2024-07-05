
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../bean/base_response_entity.dart';
import '../../bean/movie_genres_entity.dart';
import '../../bean/movie_list_entity.dart';
import '../global.dart';

part 'retrofit_client.g.dart';

///定义访问接口
///
@RestApi(baseUrl: Global.base_url + Global.version ,parser: Parser.JsonSerializable)
abstract class RetrofitClient{

  factory RetrofitClient(Dio dio, {String? baseUrl}) = _RetrofitClient;

  ///获取即将上映电影列表
  @GET('/movie/upcoming')
  Future<BaseResponseEntity<MovieListEntity>> getMovies(@Query('page') int page);

  ///获取即将电影类型
  @GET('/genre/movie/list')
  Future<BaseResponseEntity<MovieGenresEntity>> getGenreList();
  //
  // @POST('/article/query/0/json')
  // Future<BaseResponseEntity<String>> queryArticle(@Body() Map<String,dynamic> params,);

  @GET('/discover/movie')
  Future<BaseResponseEntity<MovieListEntity>> getAllMovies(@Queries() Map<String, dynamic> queries);


  // https://api.themoviedb.org/3/discover/movie?
//           include_adult=false&
//           include_video=false&
//           language=en-US&
//           page=1&
//           sort_by=primary_release_date.desc&
//           with_genres=28











}





















