import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/global/movie_manager.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';

class HomeController extends GetxController {
  // Variable
  List<MovieInfo> nowPlayingMovieList = [];
  List<MovieInfo> topRatedMovieList = [];
  List<MovieInfo> upcomingMovieList = [];
  List<MovieInfo> popularMovieList = [];

  // UI State
  // search editing controller
  final TextEditingController searchController = TextEditingController();

  // Page LifeCycle
  @override
  void onInit() {
    super.onInit();

    getPlayingMovieList();
    getTopRatedMovieList();
    getUpcomingMovieList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method
  Future<void> getPlayingMovieList() async {
    MovieManager().getMovieList();
  }

  Future<void> getTopRatedMovieList() async {
    MovieManager().getTopRatedMovieList();
  }

  Future<void> getUpcomingMovieList() async {
    MovieManager().getUpcomingMovieList();
  }

  Future<void> getPopularMovieList() async {
    MovieManager().getPopularMovieList();
  }
}
