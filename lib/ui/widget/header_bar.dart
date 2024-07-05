import 'package:cyberbot_demo/app/logger.dart';
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
class HeaderBar extends StatefulWidget implements PreferredSizeWidget {

  final String title;
  final Color backgroundColor;
  final bool darkMode;
  final bool needBack;
  final int showIconType;
  final VoidCallback? onLeftClick;
  final VoidCallback? onRightFirstClick;
  final VoidCallback? onRightSecondClick;


  HeaderBar(
      this.title,
      {
        this.backgroundColor=Colors.blue,
        this.darkMode = false,
        this.needBack = true,
        this.showIconType = ShowType.WATERFALL,
        this.onLeftClick,
        this.onRightFirstClick,
        this.onRightSecondClick
  });

  @override
  State<StatefulWidget> createState() =>  HeaderBarState();

  @override
  Size get preferredSize =>  Size.fromHeight(Dimens.d_56.h);

}

class HeaderBarState extends State<HeaderBar> {
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
      child: Stack(
        children: [
          //左边
          Positioned(
            left: 0,
            child: Obx(() =>
                IconButton(
                  icon: widget.needBack? const Icon(Icons.arrow_back,color: Colors.white,)
                      : (state.pageShowType.value == ShowType.WATERFALL
                          ? const Icon(Icons.filter,color: Colors.white): const Icon(Icons.menu,color: Colors.white) ),
                  onPressed: widget.needBack? () {
                    Get.back();
                  }:  widget.onLeftClick,
                ),
            )
          ),
          Container(
            alignment: Alignment.center,
            child: Obx(() =>
                Text(
                  state.title.value,
                  style: TextStyle(color: Colors.white, fontSize: Dimens.d_40.sp),
                )
            ),
          ),
          //右边
          Positioned(
              right: 0,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.search,color: Colors.white,),
                    onPressed: widget.onRightFirstClick,
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert,color: Colors.white,),
                    onPressed: widget.onRightSecondClick
                  ),
                ],
              )
          )

        ],
      ),
    );
  }
}
