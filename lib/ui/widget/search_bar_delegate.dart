
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyberbot_demo/app/app_data.dart';
import 'package:cyberbot_demo/app/global.dart';
import 'package:cyberbot_demo/app/logger.dart';
import 'package:cyberbot_demo/app/res/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/res/dimens.dart';
import '../../app/res/images.dart';
import '../../app/routes.dart';
import '../../bean/movie_list_entity.dart';
import '../../db/movie_list_results.dart';
import 'hero_widget.dart';

class MySearchDelegate extends SearchDelegate<String> {

  MySearchDelegate() : super(
     keyboardType: TextInputType.text,
     textInputAction: TextInputAction.search,
   ){
    nameList = AppData.getSearchWords();
  }
  ///搜索关键字 缓存偏好设置
  var nameList = <String>[];
  ///搜索结果
  List<Results> _searchResult = <Results>[];

  @override
  String get searchFieldLabel => Intl().searchPlaceholder;

  @override
  TextStyle get searchFieldStyle => TextStyle(fontSize: Dimens.d_30.sp, color: Colors.grey);


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.black,),
        onPressed: () {
          //重置
          query = "";
          //展示搜索记录
          showSuggestions(context);
        },
      )
    ];
  }

  ///返回箭头
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      //返回按钮
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation, color: Colors.black,),
      onPressed: () {
        // _loadData();

        if (query.isEmpty) {
          close(context, '');
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

   _loadData()async{
    if(query.isEmpty){
      showToast(Intl().searchPlaceholder);
      return;
    }
    _searchResult = await MoviesResultProvider().queryName(query)?? <Results>[];
  }

  ///搜索结果
  @override
  Widget buildResults(BuildContext context) {
    ///移除相同的
    if(nameList.contains(query)){
      nameList.remove(query);
    }
    ///限制最大搜索数量
    if(nameList.length >= Global.search_key_num){
      nameList.removeLast();
    }
    ///添加搜索关键字
    nameList.insert(0, query);
    AppData.saveSearchWords(nameList);

    return FutureBuilder(future: _loadData(),
        builder:(BuildContext context, AsyncSnapshot snapshot){
          return _searchResult.isNotEmpty
              ? ListView.builder(itemBuilder: (context, index){
                      return Container(
                        decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey, width: Dimens.d_1.h))),
                        padding: EdgeInsets.all(Dimens.d_15.h),
                        height: Dimens.d_120.h,
                        child: InkWell(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                HeroWidget(
                                    tag: "${_searchResult[index].id}",
                                    onTap: (){

                                    },
                                    child:CachedNetworkImage(
                                      imageUrl: _searchResult[index].posterPath,
                                      fit: BoxFit.fitWidth,
                                      placeholder: (context, url) =>
                                          Image.asset(Images.img_place),

                                    )
                                ),
                                SizedBox(width: Dimens.d_20.w,),
                                Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(_searchResult[index].title, style:
                                              TextStyle(fontSize: Dimens.d_30.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis
                                              ),maxLines: 1,),
                                        SizedBox(width: Dimens.d_15.h,),
                                        Text(_searchResult[index].overview,
                                          style: TextStyle(fontSize: Dimens.d_20.sp, color: Colors.grey,
                                              fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
                                          maxLines: 2,
                                        ),
                                      ],
                                    )
                                )
                              ],
                          ),
                          onTap: (){
                            loggerE("点击了${_searchResult[index].title}");
                            Get.toNamed(Routes.detail,
                                arguments: {"posterPath": _searchResult[index].posterPath,
                                  "id":_searchResult[index].id, "index":index} ,
                                parameters: _searchResult[index].toStringJson());
                          },
                        )
                      );
                    },
                    itemCount: _searchResult.length,
              )
              : const Center(child: Text("很抱歉，没有找到该搜索结果"));
        }
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? nameList
        : nameList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggestionsList.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: ListTile(
              title: RichText(
                      text: TextSpan(
                          text: suggestionsList[index].substring(0, query.length),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: suggestionsList[index].substring(query.length),
                                    style: const TextStyle(color: Colors.grey))
                              ]),
                    ),
            ),
            onTap: () async{
              query = suggestionsList[index];
              await _loadData();
              showResults(context);
            },
          );
        });
  }
}
