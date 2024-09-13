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

  RxBool isLoading = false.obs;

  // UI State
  // search editing controller
  final TextEditingController searchController = TextEditingController();

  // Page LifeCycle
  @override
  void onInit() {
    super.onInit();

    initMovieList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method
  void initMovieList() {
    nowPlayingMovieList = MovieManager().nowPlayingMovieList;
    topRatedMovieList = MovieManager().topRatedMovieList;
    upcomingMovieList = MovieManager().upcomingMovieList;
    popularMovieList = MovieManager().popularMovieList;

    initMovieListAsync();
  }

  Future<void> initMovieListAsync() async {
    isLoading.value = true;
    await getPlayingMovieList();
    await getTopRatedMovieList();
    await getUpcomingMovieList();
    await getPopularMovieList();
    isLoading.value = false;

    update(['now_playing', 'for_you'].toList());
  }

  Future<void> getPlayingMovieList() async {
    List<MovieInfo> latestMovieList = await MovieManager().getRemoteMovieList();

    if (latestMovieList.isNotEmpty) {
      nowPlayingMovieList = latestMovieList;
    }
  }

  Future<void> getTopRatedMovieList() async {
    List<MovieInfo> latestMovieList =
        await MovieManager().getRemoteTopRatedMovieList();

    if (latestMovieList.isNotEmpty) {
      topRatedMovieList = latestMovieList;
    }
  }

  Future<void> getUpcomingMovieList() async {
    List<MovieInfo> latestMovieList =
        await MovieManager().getRemoteUpcomingMovieList();

    if (latestMovieList.isNotEmpty) {
      upcomingMovieList = latestMovieList;
    }
  }

  Future<void> getPopularMovieList() async {
    List<MovieInfo> latestMovieList =
        await MovieManager().getRemotePopularMovieList();

    if (latestMovieList.isNotEmpty) {
      popularMovieList = latestMovieList;
    }
  }
}
