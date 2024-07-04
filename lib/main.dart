import 'package:cyberbot_demo/app/network/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/global.dart';
import 'app/logger.dart';
import 'app/res/intl.dart';
import 'app/route_observers.dart';
import 'app/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runInitApp(MyApp());
}

///初始化操作
void runInitApp(Widget app) async {
  Logger.init(tag: 'init app',isDebug: isDebug);
  ///初始化本地数据
  // await AppData.initData();
  HttpService.doInit();
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,//强制竖屏
      DeviceOrientation.portraitDown
    ]);

    return ScreenUtilInit(
        designSize: const Size(750, 1080),
        builder: (context,child) => GetMaterialApp(
          translations: Intl(),
          enableLog: true,
          initialRoute: Routes.home,
          getPages: Routes.getPages,
          navigatorObservers: [RouteObservers()],
          locale: Intl().locales[0],
          fallbackLocale: Intl().locales[0], ///默认语言选项
          supportedLocales: Intl().locales,
          localizationsDelegates: const [
            // S.delegate,
            GlobalMaterialLocalizations.delegate, /// 指定本地化的字符串和一些其他的值
            GlobalCupertinoLocalizations.delegate, /// 对应的Cupertino风格
            GlobalWidgetsLocalizations.delegate, /// 指定默认的文本排列方向, 由左到右或由右到左
          ],
          builder: (context,widget){
            return MediaQuery(///设置文字大小不随系统设置改变
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget ?? Container()
            );
          },
        )
    );
  }
}