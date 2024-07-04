
import 'package:cyberbot_demo/ui/detail/detail_binding.dart';
import 'package:cyberbot_demo/ui/detail/detail_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui/home/home_binding.dart';
import '../ui/home/home_view.dart';


class Routes {
  static final String home = "/";
  static final String detail = "/detail";
  // static final String count = "/count";
  // static final String storage = "/storage";
  // static final String connect = "/connect";
  // static final String webview = "/webview";
  // static final String rx_dart = "/rx_dart";

  static final List<GetPage> getPages=[
    GetPage(name: home, binding: HomeBinding(), page: () => HomePage()),
    GetPage(name: detail,binding: DetailBinding(), page: () => DetailPage()),
    // GetPage(name: count,binding: CountBinding(), page: () => CountPage()),
    // GetPage(name: storage,binding: StorageBinding(), page: () => StoragePage()),
    // GetPage(name: connect,binding: ConnectBinding(), page: () => ConnectPage()),
    // GetPage(name: webview,binding: WebBinding(), page: () => WebPage()),
    // GetPage(name: rx_dart,binding: RxDartBinding(), page: () => RxDartPage()),

  ];

}





