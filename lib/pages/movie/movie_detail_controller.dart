import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/global/movie_manager.dart';
import 'package:wizlah_assignment/model/movie/movie_detail.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/movie/movie_review.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/navigator/routes.dart';
import 'package:wizlah_assignment/service/app_service.dart';

class MovieDetailController extends GetxController {
  // Variable
  MovieInfo? info;

  MovieDetail? movieDetail;

  RxBool isLoading = true.obs;

  RxDouble appBarOpacity = 0.0.obs;
  final ScrollController detailController = ScrollController();

  // Movie Casting List
  List<PersonInfo> movieCastingList = <PersonInfo>[];

  // recommendation list
  List<MovieInfo> recommendationMovieList = <MovieInfo>[];

  List<MovieReview> movieReviewList = <MovieReview>[];

  // Page LifeCycle
  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;

    if (!arguments.containsKey('movieInfo')) {
      // display error state on UI
      isLoading.value = false;
      return;
    }

    info = arguments['movieInfo'] as MovieInfo;

    if (info!.id == null) {
      // display error state on UI
      isLoading.value = false;
      return;
    }
    detailController.addListener(onPageScrolling);

    _getMovieDetail(info!.id!);
  }

  @override
  void onClose() {
    detailController.removeListener(onPageScrolling);
    super.onClose();
  }

  // Listener
  void onPageScrolling() {
    if (detailController.offset == 0.0) {
      appBarOpacity.value = 0.0;
      return;
    }

    appBarOpacity.value = ((detailController.offset + kToolbarHeight) /
            (AppService().appScreenSize.height * 0.2))
        .clamp(0.0, 1.0);
  }

  // Method

  // Get Movie Detail Info
  Future<void> _getMovieDetail(int movieId) async {
    final MovieDetail? detail = await MovieManager().getMovieDetail(movieId);

    if (detail == null) {
      isLoading.value = false;
      return;
    }

    movieDetail = detail;

    await _getMovieCasting(movieId);
    await _getMovieRecommendation(movieId);
    await _getMovieReviewList(movieId);

    isLoading.value = false;
    update(['movie_detail_view'].toList());
  }

  Future<void> _getMovieCasting(int movieId) async {
    final castingList = await MovieManager().getRemoteMovieCastingList(movieId);
    movieCastingList.assignAll(castingList);
  }

  Future<void> _getMovieRecommendation(int movieId) async {
    final recommendList =
        await MovieManager().getRemoteRecommendationMovieList(movieId);

    recommendationMovieList.assignAll(recommendList);
  }

  Future<void> _getMovieReviewList(int movieId) async {
    final reviewList = await MovieManager().getRemoteMovieReviewList(movieId);

    movieReviewList.assignAll(reviewList);
  }

  // UI Interaction
  void onRecommendMovieTap(MovieInfo info) => Routes.toMovieDetail(info);

  /// Navigate to Person detail
  void goToPersonDetail(PersonInfo info) => Routes.toPersonDetail(info);

  void onRecommendRetry() async {
    await _getMovieReviewList(info!.id!);
    update(['movie_detail_view'].toList());
  }

  void onReviewRetry() async {
    await _getMovieReviewList(info!.id!);
    update(['movie_detail_view'].toList());
  }

  void onCastingRetry() async {
    await _getMovieCasting(info!.id!);
    update(['movie_detail_view'].toList());
  }
}
