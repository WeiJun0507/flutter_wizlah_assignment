import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/pages/home/home_controller.dart';
import 'package:wizlah_assignment/pages/home/home_view.dart';
import 'package:wizlah_assignment/pages/movie/movie_detail_controller.dart';
import 'package:wizlah_assignment/pages/movie/movie_detail_view.dart';
import 'package:wizlah_assignment/pages/person/person_detail_controller.dart';
import 'package:wizlah_assignment/pages/person/person_detail_view.dart';

class RouteName {
  static const String home = '/home';
  static const String movieDetail = '/movieDetail';
  static const String personDetail = '/personDetail';
}

class Routes {
  static final List<GetPage> getPages = [
    GetPage(
      name: RouteName.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
  ];

  // should check if same id exist, offAndToNamed to that route
  static toMovieDetail(MovieInfo info) {
    if (info.id == null) return;
    Get.to(
      () => MovieDetailView(tag: info.id.toString()),
      routeName: '${RouteName.movieDetail}/${info.id.toString()}',
      arguments: <String, MovieInfo>{'movieInfo': info},
      transition: Transition.cupertino,
      binding: BindingsBuilder(() {
        Get.put(MovieDetailController(), tag: info.id.toString());
      }),
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 200),
      popGesture: true,
      preventDuplicates: false,
    );
  }

  // should check if same id exist, offAndToNamed to that route
  static toPersonDetail(PersonInfo info) {
    if (info.id == null) return;
    Get.to(
      () => PersonDetailView(tag: info.id.toString()),
      routeName: '${RouteName.personDetail}/${info.id.toString()}',
      arguments: <String, PersonInfo>{'personInfo': info},
      transition: Transition.cupertino,
      binding: BindingsBuilder(() {
        Get.put(PersonDetailController(), tag: info.id.toString());
      }),
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 200),
      popGesture: true,
      preventDuplicates: false,
    );
  }
}
