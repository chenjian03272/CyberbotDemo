
import 'dart:ui';
import 'package:get/get.dart';

class Intl extends Translations{
  Intl._internal();
  static Intl? instance;

  static getInstance(){
    instance ??= Intl._internal();
    return instance;
  }

  factory Intl()=> getInstance();


  var locales = [const Locale('en','US'), const Locale('zh','ZH')];


  String get homePageTitle => 'homePageTitle'.tr;
  String get upcoming => 'upcoming'.tr;
  String get originalTitle => 'originalTitle'.tr;
  String get releaseDate => 'releaseDate'.tr;
  String get allGenres => 'allGenres'.tr;
  String get overview => 'overview'.tr;
  String get search => 'search'.tr;
  String get searchPlaceholder => 'searchPlaceholder'.tr;
  String get searchToast => 'searchToast'.tr;


  String get connect => 'connect'.tr;
  String get getx_get => 'getx_get'.tr;
  String get getx_post => 'getx_post'.tr;
  String get count => 'count'.tr;
  String get home => 'home'.tr;
  String get activity => 'activity'.tr;
  String get other => 'other'.tr;
  String get sayHello => 'sayHello'.tr;
  String get multiple => 'multiple'.tr;
  String get app_name => 'app_name'.tr;
  String get greet => 'greet'.tr;

  String get language => 'language'.tr;
  String get storage => 'storage'.tr;
  String get theme => 'theme'.tr;
  String get permission => 'permission'.tr;
  String get webview => 'webview'.tr;
  String get pictureSelector => 'pictureSelector'.tr;
  String get userEventBus => 'userEventBus'.tr;


  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      "homePageTitle": "Movie List",
      "app_name": "Movies",
      "upcoming": "UpComing",
      "originalTitle": "Original Title",
      "releaseDate": "Release Date",
      "allGenres": "All Movies",
      "overview": "Overview",
      "search": "Search",
      "searchPlaceholder": "Enter keywords to search",
      "home": "Home",
      "activity": "activity",
      "other": "other",
      "greet": "hello~",


    },
    'cn_ZH': {
      "homePageTitle": "电影列表",
      "app_name": "影讯",
      "upcoming": "即将上映",
      "originalTitle": "原名",
      "releaseDate": "上映日期",
      "allGenres": "电影列表",
      "overview": "概述",
      "search": "搜索",
      "searchPlaceholder": "输入关键词查找",
      "home": "首页",
      "activity": "活动",
      "other": "其他",

    }
  };


}

