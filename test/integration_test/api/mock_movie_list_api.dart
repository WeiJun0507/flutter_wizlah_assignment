import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/response/movie_list_response.dart';

class MockMovieListApi {
  MockMovieListApi._();

  // get movie upcoming list
  static Future<List<MovieInfo>> getUpcomingMovie() async {
    try {
      final Map<String, dynamic> data = await loadJson(
        'test/integration_test/api/upcoming_movie_response.json',
      );

      return MovieListResponse.fromJson(data).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  // get movie now playing list
  static Future<List<MovieInfo>> getNowPlayingList() async {
    try {
      final Map<String, dynamic> data = await loadJson(
        'test/integration_test/api/now_playing_movie_response.json',
      );

      return MovieListResponse.fromJson(data).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  // get movie popular] list
  static Future<List<MovieInfo>> getPopularList() async {
    try {
      final Map<String, dynamic> data = await loadJson(
        'test/integration_test/api/popular_movie_response.json',
      );

      return MovieListResponse.fromJson(data).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  // get movie top rated list
  static Future<List<MovieInfo>> getTopRatedList() async {
    try {
      final Map<String, dynamic> data = await loadJson(
        'test/integration_test/api/top_rated_movie_response.json',
      );

      return MovieListResponse.fromJson(data).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  static Future<Map<String, dynamic>> loadJson(String path) async {
    // Load the JSON file from the test folder
    final data = await rootBundle.loadString(path);

    // Decode the JSON into a Map
    return jsonDecode(data) as Map<String, dynamic>;
  }
}
