import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/util/common.dart';

class MovieListResponse {
  Date? dates;
  int? page;
  List<MovieInfo>? results;
  int? totalPages;
  int? totalResults;

  MovieListResponse(
      {this.dates,
      this.page,
      this.results,
      this.totalPages,
      this.totalResults});

  @override
  MovieListResponse.fromJson(Map<String, dynamic> json) {
    dates = Date.fromJson(json['dates']);
    page = json['page'];
    if (json['results'] != null) {
      results = <MovieInfo>[];
      json['results'].forEach((v) {
        results!.add(MovieInfo.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dates != null) {
      data['dates'] = dates!.toJson();
    }
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
