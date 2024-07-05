import 'dart:convert';
import 'dart:ui';

import 'package:cyberbot_demo/app/global.dart';
import 'package:cyberbot_demo/app/network/retrofit_client.dart';
import 'package:cyberbot_demo/bean/movie_genres_entity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../bean/base_response_entity.dart';
import '../../bean/movie_list_entity.dart';
import '../logger.dart';
import '../res/intl.dart';
import 'error_response_handler.dart';
class HttpService{

  static late RetrofitClient _client;

  static void doInit(){
    var dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler){
        // options.headers["Content-Type"] = "application/x-www-form-urlencoded";
        options.headers["accept"] = "application/json";
        options.headers["Authorization"] = Global.Authorization;
        //公用参数
        String language = Get.locale?.languageCode?? Intl().locales[0].languageCode;
        var commonParams = {"api_key": Global.key, "language": language};
        options.queryParameters.addAll(commonParams);
        loggerArray(["发起请求","${options.baseUrl}${options.path}\n","${options.method}\n","${options.headers}\n",options.data ?? options.queryParameters]);
        handler.next(options);
      },
      onResponse: (response, handler){
        loggerArray(["返回响应",response.requestOptions.path,response.statusCode,"${response.statusMessage}\n",jsonEncode(response.data)]);
        if(response.statusCode == 200){
          handler.next(response);
        }else {
          ErrorResponseHandler().onErrorHandle({"code": response.statusCode,"message": response.statusMessage});
        }
      },
      onError: (DioException e, handler){
        loggerArray(["异常响应",e.toString()]);
        handler.next(e);
      }
    ));
    _client = RetrofitClient(dio);
  }



  ///封装请求体，自动处理各种异常问题
  static Future<T> buildFuture<T>(RequestCallback callback,{bool loading = true,bool needMsg = false,bool errorHandler = true}) async {
    // if(loading){ EasyLoading.show(maskType: EasyLoadingMaskType.black,status: Intr().jiazaizhong); }
    try{
      var value = await callback.call();
      // if(loading){ EasyLoading.dismiss(); }
      if(value.isOk()){
        ///data为null时处理
        return Future.value(value.data ?? (needMsg ? value.errorMsg.toString():""));
      } else {
        if(errorHandler){ ErrorResponseHandler().onErrorHandle({"code": value.errorCode,"message": value.errorMsg.toString()}); }
        return Future.error(value.errorMsg.toString());
      }
    }catch(error){
      loggerArray(["请求异常信息",error]);
      // if(loading){ EasyLoading.dismiss(); }
      if(errorHandler){ ErrorResponseHandler().onErrorHandle(error); }
      return Future.error(error);
    }
  }


  static Future<MovieListEntity> getMoviesList(int page){
    return buildFuture<MovieListEntity>(()=> _client.getMovies( page),loading: true);
  }

  static Future<MovieGenresEntity> getGenresList(){
    return buildFuture<MovieGenresEntity>(()=> _client.getGenreList(),loading: true);
  }

  // https://api.themoviedb.org/3/discover/movie?
//           include_adult=false&
//           include_video=false&
//           language=en-US&
//           page=1&
//           sort_by=primary_release_date.desc&
//           with_genres=28

  static Future<MovieListEntity> getAllMovies(int page, {int genres = Global.DefaultGenres}){
    Map<String,dynamic> params = <String,dynamic>{};
    params["include_adult"] = false;
    params["include_video"] = false;
    params["page"] = page;
    params["sort_by"] = "primary_release_date.desc";
    if(genres != Global.DefaultGenres){
      params["with_genres"] = genres;
    }
    return buildFuture<MovieListEntity>(()=> _client.getAllMovies(params),loading: false);
  }





}


typedef RequestCallback = Future<BaseResponseEntity<dynamic>> Function();
