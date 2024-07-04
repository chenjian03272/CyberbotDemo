
import 'dart:ui';

import 'package:cyberbot_demo/app/res/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyStyle{

  static Widget BottomSheetContainer({Widget child = const Text("没传布局啊"), double? height}){

    return Container(
      height: height,
      padding: EdgeInsets.all(Dimens.d_30.w),
      decoration: const BoxDecoration(color: Colors.white,
          borderRadius:BorderRadius.only(topLeft: Radius.circular(Dimens.d_15),
              topRight: Radius.circular(Dimens.d_15), bottomLeft: Radius.zero,
              bottomRight: Radius.zero)
      ),
      child: child,

    );
  }

}