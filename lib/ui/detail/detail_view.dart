import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyberbot_demo/app/res/intl.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cyberbot_demo/app/logger.dart';
import 'package:cyberbot_demo/ui/widget/header_bar.dart';
import 'package:cyberbot_demo/ui/widget/hero_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/res/dimens.dart';
import '../../app/res/images.dart';
import '../../app/res/my_style.dart';
import '../home/home_logic.dart';
import '../widget/bottom_space_text.dart';
import 'detail_logic.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final logic = Get.find<DetailLogic>();
  final state = Get.find<DetailLogic>().state;
  DefaultCacheManager cacheManager = DefaultCacheManager();

  @override
  void initState() {
    super.initState();
    // cacheManager.getSingleFile(url)
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
        child: Stack(
      children: [
        HeroWidget(
          width: double.infinity,
          tag: logic.getImageTag(),
          child: CachedNetworkImage(
            imageUrl: logic.getOriImagePath(),
            fit: BoxFit.fitWidth,
            placeholder: (context, url) => CachedNetworkImage(
              imageUrl: logic.getImagePath(),
              fit: BoxFit.fitWidth,
            ),
          ),
          onTap: () {
            Get.back();
          },
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: Dimens.d_600.h,
            child: HeroWidget(
              tag: logic.getDescTag(),
              onTap: () {
                Get.back();
              },
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
                          logic.getSelectMoviesItem()?.title??"",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Dimens.d_60.sp,decoration: TextDecoration.none),
                        ),
                        paddingBottom: Dimens.d_20.h,
                      ),
                      BottomSpaceText(
                        Text(
                          "${Intl().originalTitle}：${logic.getSelectMoviesItem()?.originalTitle??""}",
                          style: TextStyle(color: Colors.white, fontSize: Dimens.d_30.sp,decoration: TextDecoration.none),
                        ),
                        paddingBottom: Dimens.d_15.h,
                      ),
                      BottomSpaceText(
                        Text(
                          """${Intl().releaseDate}：${logic.getSelectMoviesItem()?.releaseDate??''}   ${Intl().language}：${logic.getSelectMoviesItem()?.originalLanguage??''} """,
                          style: TextStyle(color: Colors.white, fontSize: Dimens.d_30.sp,decoration: TextDecoration.none),
                        ),
                        paddingBottom: Dimens.d_15.h,
                      ),
                      BottomSpaceText(
                        Text(
                          "${Intl().overview}：${logic.getSelectMoviesItem()?.overview??""}",
                          style: TextStyle(color: Colors.white, fontSize: Dimens.d_30.sp,decoration: TextDecoration.none),
                        ),
                        paddingBottom: Dimens.d_15.h,
                      ),

                    ],

                  ),
                )

              ),
            )
        )


      ],
    ));
  }

  @override
  void dispose() {
    Get.delete<DetailLogic>();
    super.dispose();
  }
}
