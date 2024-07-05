import 'package:cyberbot_demo/app/res/dimens.dart';
import 'package:cyberbot_demo/app/res/intl.dart';
import 'package:cyberbot_demo/ui/home/masonry_movies_view.dart';
import 'package:cyberbot_demo/ui/home/movies_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/res/my_style.dart';
import '../../app/routes.dart';
import '../widget/header_bar.dart';
import '../widget/load_state.dart';
import '../widget/search_bar_delegate.dart';
import 'home_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;
  ///列表滑动监听
  final _scrollController =  ScrollController(initialScrollOffset: 0);
  ///电影类型滑动监听
  final _genresScrollController =  ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var px = _scrollController.position.pixels;
      if (px == _scrollController.position.maxScrollExtent) {
        logic.onLoadMore();
      }
    });
  }


  ///标题
  HeaderBar getHeadBar(){
    return HeaderBar(
      Intl().upcoming,
      needBack: false,
      onLeftClick: (){
        logic.changeShowType();
      },
      onRightFirstClick: (){
        //搜索电影
        showSearch(context: context, delegate: MySearchDelegate());
      },
      onRightSecondClick: (){
        //类型筛选
        Get.bottomSheet(
            getBottomSheetOfGenres(),
        );
        //滑动到已选项
        Future.delayed(const Duration(milliseconds: 500), (){
          _genresScrollController.animateTo(
              logic.getSelectMoviesGenresIndex() * Dimens.d_80.h,
              duration: const Duration(milliseconds: 300),
            curve: const ElasticOutCurve()
          );
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getHeadBar(),
        body:  Obx(() =>
        state.pageShowType.value == ShowType.WATERFALL ?
        MasonryMoviesView(//瀑布流
            _scrollController,
                (index){
              Get.toNamed(Routes.detail,
                  arguments: {"posterPath": state.moviesList.value[index].posterPath,
                    "id":state.moviesList.value[index].id, "index":index} );
            }
        ):
        const MoviesPageView()//翻页
        )

    );
  }

  ///获取电影类型筛选弹窗
  Widget getBottomSheetOfGenres(){
    return MyStyle.BottomSheetContainer(
        height: Dimens.d_500.h,
        child: Obx(() =>
            ListView.builder(
                controller: _genresScrollController,
                itemCount: state.genresList.value.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: Dimens.d_1.h))),
                      padding: EdgeInsets.only(left: Dimens.d_20.h, right: Dimens.d_20.h),
                      height: Dimens.d_80.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.genresList.value[index].name,
                            style: TextStyle(color: Colors.black, fontSize: Dimens.d_30.sp),
                          ),
                          Checkbox(
                              value: state.genresList.value[index].isCheck,
                              onChanged: (isCheck){},
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      logic.checkMoviesGenres(index);
                      Get.back();
                    },
                  );
                }
            )
        )
    );
  }



  @override
  void dispose() {
    Get.delete<HomeLogic>();
    super.dispose();
  }
}