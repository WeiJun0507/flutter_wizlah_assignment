import 'dart:convert';

import 'package:wizlah_assignment/api/common.dart';
import 'package:wizlah_assignment/api/movie.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/util/common.dart';
import 'package:wizlah_assignment/service/local_storage_service.dart';

class MovieManager {
  static final MovieManager _instance = MovieManager._internal();

  factory MovieManager() => _instance;

  MovieManager._internal();

  List<Genre> genreList = [];

  void init() {
    genreList = _localGenreList;

    initAsync();
  }

  Future<void> initAsync() async {
    getRemoteGenre();
  }

  Future<void> getRemoteGenre() async {
    genreList = await CommonApi.getMovieGenre();

    if (genreList.isNotEmpty) {
      LocalStorageService().prefs.setString(
            LocalStorageService.genre,
            jsonEncode(genreList),
          );
    }
  }

  /// Get the now playing movie list from remote API call
  Future<List<MovieInfo>> getRemoteMovieList({
    String language = 'en-US',
    int page = 1,
  }) async {
    final playingMovieList = await MovieApi.getNowPlayingList(
      language: language,
      page: page,
    );

    if (page == 1 && playingMovieList.isNotEmpty) {
      LocalStorageService().prefs.setString(
            LocalStorageService.nowPlayingMovieList,
            jsonEncode(playingMovieList),
          );
    }

    return playingMovieList;
  }

  Future<List<MovieInfo>> getRemoteTopRatedMovieList({
    String language = 'en-US',
    int page = 1,
  }) async {
    final playingMovieList = await MovieApi.getTopRatedList(
      language: language,
      page: page,
    );

    if (page == 1 && playingMovieList.isNotEmpty) {
      LocalStorageService().prefs.setString(
            LocalStorageService.topRatedMovieList,
            jsonEncode(playingMovieList),
          );
    }

    return playingMovieList;
  }

  Future<List<MovieInfo>> getRemoteUpcomingMovieList({
    String language = 'en-US',
    int page = 1,
  }) async {
    final playingMovieList = await MovieApi.getUpcomingMovie(
      language: language,
      page: page,
    );

    if (page == 1 && playingMovieList.isNotEmpty) {
      LocalStorageService().prefs.setString(
            LocalStorageService.upcomingMovieList,
            jsonEncode(playingMovieList),
          );
    }

    return playingMovieList;
  }

  Future<List<MovieInfo>> getRemotePopularMovieList({
    String language = 'en-US',
    int page = 1,
  }) async {
    final playingMovieList = await MovieApi.getPopularList(
      language: language,
      page: page,
    );

    if (page == 1 && playingMovieList.isNotEmpty) {
      LocalStorageService().prefs.setString(
            LocalStorageService.popularMovieList,
            jsonEncode(playingMovieList),
          );
    }

    return playingMovieList;
  }

  Future<List<MovieInfo>> getSearchedMovieResult(
    String query, {
    int page = 1,
  }) async {
    return MovieApi.searchMovieByQueries(
      query,
      page: page,
    );
  }

  // call once from initialization
  List<Genre> get _localGenreList {
    final genre =
        LocalStorageService().prefs.getString(LocalStorageService.genre);
    if (genre?.isNotEmpty ?? false) {
      return jsonDecode(genre!).map<Genre>((e) => Genre.fromJson(e)).toList();
    }

    return <Genre>[];
  }

  List<MovieInfo> get nowPlayingMovieList {
    final playingList = LocalStorageService()
        .prefs
        .getString(LocalStorageService.nowPlayingMovieList);
    if (playingList?.isNotEmpty ?? false) {
      return jsonDecode(playingList!)
          .map<MovieInfo>((e) => MovieInfo.fromJson(e))
          .toList();
    }

    return <MovieInfo>[];
  }

  List<MovieInfo> get upcomingMovieList {
    final playingList = LocalStorageService()
        .prefs
        .getString(LocalStorageService.upcomingMovieList);
    if (playingList?.isNotEmpty ?? false) {
      return jsonDecode(playingList!)
          .map<MovieInfo>((e) => MovieInfo.fromJson(e))
          .toList();
    }

    return <MovieInfo>[];
  }

  List<MovieInfo> get topRatedMovieList {
    final playingList = LocalStorageService()
        .prefs
        .getString(LocalStorageService.topRatedMovieList);
    if (playingList?.isNotEmpty ?? false) {
      return jsonDecode(playingList!)
          .map<MovieInfo>((e) => MovieInfo.fromJson(e))
          .toList();
    }

    return <MovieInfo>[];
  }

  List<MovieInfo> get popularMovieList {
    final playingList = LocalStorageService()
        .prefs
        .getString(LocalStorageService.popularMovieList);
    if (playingList?.isNotEmpty ?? false) {
      return jsonDecode(playingList!)
          .map<MovieInfo>((e) => MovieInfo.fromJson(e))
          .toList();
    }

    return <MovieInfo>[];
  }
}
