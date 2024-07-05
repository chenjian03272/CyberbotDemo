
import 'package:cyberbot_demo/ui/detail/detail_binding.dart';
import 'package:cyberbot_demo/ui/detail/detail_view.dart';
import 'package:cyberbot_demo/ui/search/search_binding.dart';
import 'package:cyberbot_demo/ui/search/search_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui/home/home_binding.dart';
import '../ui/home/home_view.dart';


class Routes {
  static final String home = "/";
  static final String detail = "/detail";
  static final String search = "/search";

  static final List<GetPage> getPages=[
    GetPage(name: home, binding: HomeBinding(), page: () => HomePage()),
    GetPage(name: detail,binding: DetailBinding(), page: () => DetailPage()),
    GetPage(name: search,binding: SearchBinding(), page: () => SearchPage()),

  ];

}





