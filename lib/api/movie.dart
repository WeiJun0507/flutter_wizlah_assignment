import 'package:wizlah_assignment/api/http_util.dart';
import 'package:wizlah_assignment/model/movie/movie_detail.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/response/movie_list_response.dart';

class MovieApi {
  static const String _prefix = 'movie';

  // get movie upcoming list
  static Future<List<MovieInfo>> getUpcomingMovie({
    String language = 'en-US',
    int page = 1,
    String? region,
  }) async {
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

    return MovieListResponse.fromJson(res).results ?? [];
  }

  // get movie now playing list
  static Future<List<MovieInfo>> getNowPlayingList({
    String language = 'en-US',
    int page = 1,
    String? region,
  }) async {
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

    return MovieListResponse.fromJson(res).results ?? [];
  }

  // get movie popular] list
  static Future<List<MovieInfo>> getPopularList({
    String language = 'en-US',
    int page = 1,
    String? region,
  }) async {
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

    return MovieListResponse.fromJson(res).results ?? [];
  }

  // get movie top rated list
  static Future<List<MovieInfo>> getTopRatedList({
    String language = 'en-US',
    int page = 1,
    String? region,
  }) async {
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

    return MovieListResponse.fromJson(res).results ?? [];
  }

  static Future<MovieDetail> getMovieDetail(
    int movieId, {
    String? appendToResponse,
    String language = 'en-US',
  }) async {
    String urlPath = '$_prefix/$movieId';
    final res = await HttpUtil().fetch(
      FetchType.get,
      url: urlPath,
      queryParameters: {
        if (appendToResponse != null) 'append_to_response': appendToResponse,
      },
    );

    return MovieDetail.fromJson(res);
  }

  static Future searchMovieByQueries(
    String query, {
    bool includeAdult = false,
    String language = 'en-US',
    String? primaryReleaseYear,
    int page = 1,
    String? region,
    String? year,
  }) async {
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
  }
}
