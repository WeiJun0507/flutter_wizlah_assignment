import 'dart:convert';

import 'package:wizlah_assignment/api/common.dart';
import 'package:wizlah_assignment/api/movie.dart';
import 'package:wizlah_assignment/model/util/common.dart';
import 'package:wizlah_assignment/service/local_storage.dart';

class MovieManager {
  static final MovieManager _instance = MovieManager._internal();

  factory MovieManager() => _instance;

  MovieManager._internal();

  List<Genre> genreList = [];

  Future<void> init() async {
    // genreList = await CommonApi.getMovieGenre();

    if (genreList.isEmpty) {
      final genre =
          LocalStorageService().prefs.getString(LocalStorageService.GENRE);
      if (genre?.isNotEmpty ?? false) {
        genreList =
            jsonDecode(genre!).map<Genre>((e) => Genre.fromJson(e)).toList();
      }
    }
  }

  // todo: try catch and return data
  // todo: data persistent?
  Future getMovieList() async {
    final playingMovieList = await MovieApi.getNowPlayingList();
  }

  Future getTopRatedMovieList() async {
    final playingMovieList = await MovieApi.getTopRatedList();
  }

  Future getUpcomingMovieList() async {
    final playingMovieList = await MovieApi.getUpcomingMovie();
  }

  Future getPopularMovieList() async {
    final playingMovieList = await MovieApi.getPopularList();
  }
}
