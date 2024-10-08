import 'dart:math';

import 'package:wizlah_assignment/api/http_util.dart';
import 'package:wizlah_assignment/model/movie/movie_detail.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/movie/movie_review.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/model/response/movie_cast_response.dart';
import 'package:wizlah_assignment/model/response/movie_list_response.dart';
import 'package:wizlah_assignment/model/response/movie_review_response.dart';

class MovieApi {
  static const String _prefix = 'movie';

  MovieApi._();

  // get movie upcoming list
  static Future<List<MovieInfo>> getUpcomingMovie({
    String language = 'en-US',
    int page = 1,
    String? region,
  }) async {
    try {
      String urlPath = '$_prefix/upcoming';

      final res = await HttpUtil().fetch(
        FetchType.get,
        url: urlPath,
        queryParameters: {
          'language': language,
          'page': page.toString(),
          if (region != null) 'region': region,
        },
      );

      return MovieListResponse.fromJson(res).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  // get movie now playing list
  static Future<List<MovieInfo>> getNowPlayingList({
    String language = 'en-US',
    int page = 1,
    String? region,
  }) async {
    try {
      String urlPath = '$_prefix/now_playing';

      final res = await HttpUtil().fetch(
        FetchType.get,
        url: urlPath,
        queryParameters: {
          'language': language,
          'page': page.toString(),
          if (region != null) 'region': region,
        },
      );

      return MovieListResponse.fromJson(res).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  // get movie popular] list
  static Future<List<MovieInfo>> getPopularList({
    String language = 'en-US',
    int page = 1,
    String? region,
  }) async {
    try {
      String urlPath = '$_prefix/popular';

      final res = await HttpUtil().fetch(
        FetchType.get,
        url: urlPath,
        queryParameters: {
          'language': language,
          'page': page.toString(),
          if (region != null) 'region': region,
        },
      );

      return MovieListResponse.fromJson(res).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  // get movie top rated list
  static Future<List<MovieInfo>> getTopRatedList({
    String language = 'en-US',
    int page = 1,
    String? region,
  }) async {
    try {
      String urlPath = '$_prefix/top_rated';

      final res = await HttpUtil().fetch(
        FetchType.get,
        url: urlPath,
        queryParameters: {
          'language': language,
          'page': page.toString(),
          if (region != null) 'region': region,
        },
      );

      return MovieListResponse.fromJson(res).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  static Future<MovieDetail?> getMovieDetail(
    int movieId, {
    String? appendToResponse,
    String language = 'en-US',
  }) async {
    String urlPath = '$_prefix/$movieId';
    try {
      final res = await HttpUtil().fetch(
        FetchType.get,
        url: urlPath,
        queryParameters: {
          if (appendToResponse != null) 'append_to_response': appendToResponse,
        },
      );

      return MovieDetail.fromJson(res);
    } catch (e) {
      return null;
    }
  }

  static Future<List<MovieInfo>> searchMovieByQueries(
    String query, {
    bool includeAdult = false,
    String language = 'en-US',
    String? primaryReleaseYear,
    int page = 1,
    String? region,
    String? year,
  }) async {
    try {
      String urlPath = 'search/$_prefix';

      final res = await HttpUtil().fetch(
        FetchType.get,
        url: urlPath,
        queryParameters: {
          'query': query,
          'include_adult': includeAdult ? 'true' : 'false',
          'language': language,
          if (primaryReleaseYear != null)
            'primary_release_year': primaryReleaseYear,
          'page': page.toString(),
          if (region != null) 'region': region,
          if (year != null) 'year': year,
        },
      );

      return MovieListResponse.fromJson(res).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  static Future<List<PersonInfo>> getMovieCastingList(
    int movieId, {
    String language = 'en-US',
  }) async {
    try {
      String urlPath = '$_prefix/$movieId/credits';

      final Map<String, dynamic> res = await HttpUtil().fetch(
        FetchType.get,
        url: urlPath,
        queryParameters: {
          'language': language,
        },
      );

      return MovieCastResponse.fromJson(res).cast ?? <PersonInfo>[];
    } catch (e) {
      return <PersonInfo>[];
    }
  }

  static Future<List<MovieInfo>> getRecommendationMovie(
    int movieId, {
    String language = 'en-US',
    int page = 1,
  }) async {
    try {
      String urlPath = '$_prefix/$movieId/recommendations';

      final Map<String, dynamic> res = await HttpUtil().fetch(
        FetchType.get,
        url: urlPath,
        queryParameters: {
          'language': language,
          'page': page.toString(),
        },
      );

      if (res.containsKey('results')) {
        res['results'] = (res['results'] as List)
            .getRange(0, min(res['results'].length, 10));
      }

      return MovieListResponse.fromJson(res).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  static Future<List<MovieInfo>> getSimilarMovie(
    int movieId, {
    String language = 'en-US',
    int page = 1,
  }) async {
    try {
      String urlPath = '$_prefix/$movieId/similar';

      final res = await HttpUtil().fetch(
        FetchType.get,
        url: urlPath,
        queryParameters: {
          'language': language,
          'page': page.toString(),
        },
      );

      return MovieListResponse.fromJson(res).results ?? <MovieInfo>[];
    } catch (e) {
      return <MovieInfo>[];
    }
  }

  static Future<List<MovieReview>> getMovieReviews(
    int movieId, {
    String language = 'en-US',
    int page = 1,
  }) async {
    try {
      String urlPath = '$_prefix/$movieId/reviews';

      final res = await HttpUtil().fetch(
        FetchType.get,
        url: urlPath,
        queryParameters: {
          'language': language,
          'page': page.toString(),
        },
      );

      return MovieReviewResponse.fromJson(res).results ?? <MovieReview>[];
    } catch (e) {
      return <MovieReview>[];
    }
  }
}
