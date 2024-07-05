import 'package:cyberbot_demo/app/logger.dart';
import 'package:cyberbot_demo/app/res/intl.dart';
import 'package:cyberbot_demo/ui/widget/load_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:retrofit/http.dart';

import '../../app/res/dimens.dart';
import '../home/home_logic.dart';

///通用标题组件
///包含 标题  ，左边一个图标按钮， 右边俩个图标按钮
class SearchBar extends StatefulWidget implements PreferredSizeWidget {

  final Color backgroundColor;
  final bool darkMode;
  final VoidCallback? onLeftClick;
  final VoidCallback? onSearchClick;


  SearchBar(
      {
        this.backgroundColor=Colors.blue,
        this.darkMode = false,
        this.onLeftClick,
        this.onSearchClick,
  });

  @override
  State<StatefulWidget> createState() =>  HeaderBarState();

  @override
  Size get preferredSize =>  Size.fromHeight(Dimens.d_56.h);

}

class HeaderBarState extends State<SearchBar> {
  final state = Get.find<HomeLogic>().state;
  bool needBack = false;
  @override
  Widget build(BuildContext context) {
    ///设置状态栏和导航栏主题风格
    SystemChrome.setSystemUIOverlayStyle(widget.darkMode?SystemUiOverlayStyle.dark:SystemUiOverlayStyle.light);
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight,),
      color: widget.backgroundColor,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          IconButton(
              onPressed: (){
                Get.back();
              },
              icon: const Icon(Icons.arrow_back,color: Colors.white,),
          ),
          Expanded(
              child: TextField(

              )
          ),


        ],
      )

      // Stack(
      //   children: [
      //     //左边
      //     Positioned(
      //       left: 0,
      //       child: Obx(() =>
      //           IconButton(
      //             icon: const Icon(Icons.arrow_back,color: Colors.white,),
      //             onPressed:() {
      //               Get.back();
      //             },
      //           ),
      //       )
      //     ),
      //     Container(
      //       alignment: Alignment.center,
      //       child: Obx(() =>
      //           Text(
      //             state.title.value,
      //             style: TextStyle(color: Colors.white, fontSize: Dimens.d_40.sp),
      //           )
      //       ),
      //     ),
      //     //右边
      //     Positioned(
      //         right: 0,
      //         child: TextButton(
      //           child: Text(Intl().search),
      //           onPressed: widget.onSearchClick,
      //         )
      //     )
      //
      //   ],
      // ),
    );
  }
}
