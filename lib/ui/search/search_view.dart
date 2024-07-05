import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_logic.dart';

///搜索页面
class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final logic = Get.find<SearchLogic>();
  final state = Get.find<SearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

  @override
  void dispose() {
    Get.delete<SearchLogic>();
    super.dispose();
  }
}