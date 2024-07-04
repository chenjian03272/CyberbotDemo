
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyberbot_demo/ui/detail/detail_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/res/dimens.dart';
import '../../app/res/intl.dart';
import '../widget/bottom_space_text.dart';
import 'home_logic.dart';
///左右滑动浏览
class MoviesPageView extends StatefulWidget{
  const MoviesPageView(
      {super.key}
  );

  @override
  State<StatefulWidget> createState() {
    return _MoviesPageViewState();
  }

}

class _MoviesPageViewState extends State{
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  late PageController _pageController ;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }



  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        PageView.builder(
          itemBuilder: (BuildContext context, int index){
            return Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: logic.getOriImagePath(index),
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => CachedNetworkImage(
                    imageUrl: state.moviesList.value[index].posterPath,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: Dimens.d_600.h,
                    child: Container(
                          color: const Color(0xa5000000),
                          // height:  Dimens.d_500.h,
                          padding: EdgeInsets.all(Dimens.d_20.w),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BottomSpaceText(
                                  Text(
                                    state.moviesList.value[index].title??"",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Dimens.d_60.sp,decoration: TextDecoration.none),
                                  ),
                                  paddingBottom: Dimens.d_20.h,
                                ),
                                BottomSpaceText(
                                  Text(
                                    "${Intl().originalTitle}：${state.moviesList.value[index].originalTitle??""}",
                                    style: TextStyle(color: Colors.white, fontSize: Dimens.d_30.sp,decoration: TextDecoration.none),
                                  ),
                                  paddingBottom: Dimens.d_15.h,
                                ),
                                BottomSpaceText(
                                  Text(
                                    """${Intl().releaseDate}：${state.moviesList.value[index].releaseDate??''}   ${Intl().language}：${state.moviesList.value[index].originalLanguage??''} """,
                                    style: TextStyle(color: Colors.white, fontSize: Dimens.d_30.sp,decoration: TextDecoration.none),
                                  ),
                                  paddingBottom: Dimens.d_15.h,
                                ),
                                BottomSpaceText(
                                  Text(
                                    "${Intl().overview}：${state.moviesList.value[index].overview??""}",
                                    style: TextStyle(color: Colors.white, fontSize: Dimens.d_30.sp,decoration: TextDecoration.none),
                                  ),
                                  paddingBottom: Dimens.d_15.h,
                                ),

                              ],

                            ),
                          )

                      ),
                )

              ],
            );
          },
          itemCount: state.moviesList.value.length,
          onPageChanged: (int index){
              if(index > state.moviesList.value.length - 3){
                logic.onLoadMore();
              }
          },
        )
    );
  }

}