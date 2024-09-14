import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/pages/home/home_controller.dart';
import 'package:wizlah_assignment/pages/home/home_view.dart';
import 'package:wizlah_assignment/pages/movie/movie_detail_controller.dart';
import 'package:wizlah_assignment/pages/movie/movie_detail_view.dart';

class RouteName {
  static const String home = '/home';
  static const String movieDetail = '/movieDetail';
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

  static toMovieDetail(MovieInfo info) {
    if (info.id == null) return;
    Get.to(
      () => MovieDetailView(tag: info.id.toString()),
      routeName: '/movieDetail/${info.id.toString()}',
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
}
