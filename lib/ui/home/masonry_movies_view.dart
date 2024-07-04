
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyberbot_demo/ui/widget/hero_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../app/res/dimens.dart';
import '../../app/res/images.dart';
import '../../callback/common_callback.dart';
import 'home_logic.dart';
import '../widget/load_state.dart';

class MasonryMoviesView extends StatelessWidget{
  MasonryMoviesView(
      this.controller,
      this.onImageClck,
      {super.key}
  );

  final ScrollController controller;
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;
  final OneParamsCallback? onImageClck;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
              onRefresh: () async{
                logic.onRefreshList();
              },
              child: getMoviesGridView()
          ),
        ),
        loadMoreView()
      ],
    );
  }
  ///获取电影列表瀑布流布局
  Widget getMoviesGridView(){
    return Obx(() =>
        MasonryGridView.count(
          controller: controller,
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: state.itemCount.value,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                HeroWidget(
                    tag: "${state.moviesList.value[index].id}",
                    onTap: (){
                      if(onImageClck != null){
                        onImageClck!(index);
                      }
                    },
                    child:CachedNetworkImage(
                      imageUrl: state.moviesList.value[index].posterPath,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) =>
                          Image.asset(Images.img_place),

                    )
                ),

                //电影文字介绍
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: HeroWidget(
                      tag: "${state.moviesList.value[index].id}-$index",
                      // onTap: (){
                      //   if(onImageClck != null){
                      //     onImageClck!(index);
                      //   }
                      // },
                      child:Container(
                          height: Dimens.d_120.h,
                          padding: EdgeInsets.all(Dimens.d_10.w),
                          color: const Color(0xa5000000),
                          child: Column(
                            children: [
                              Text(//电影标题
                                  state.moviesList.value[index].title,
                                  style: TextStyle(color: Colors.white, fontSize: Dimens.d_30.sp,overflow: TextOverflow.ellipsis,decoration: TextDecoration.none),
                                  maxLines:1
                              ),
                              //日期  类别
                              Text(
                                // "${state.moviesList.value[index].releaseDate} | ${state.moviesList.value[index].genreIds[0]}"  ,
                                "${state.moviesList.value[index].releaseDate} | "  ,
                                style: TextStyle(color: Colors.white, fontSize: Dimens.d_18.sp,decoration: TextDecoration.none),
                              ),
                              //电影简介
                              Text(
                                state.moviesList.value[index].overview,
                                style: TextStyle(color: Colors.white, fontSize: Dimens.d_18.sp,overflow: TextOverflow.ellipsis,decoration: TextDecoration.none),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      )
                )

              ],
            );
          },
        ),
    );
  }

  ///底部加载更多
  Widget loadMoreView(){
    return Obx(() =>
        Offstage(
          offstage: state.loadState.value != LoadState.LOADING,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 10),
                      child: const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text("加载更多..."),
                  )

                ],
              ),
            ),
          ),
        )
    );
  }
}