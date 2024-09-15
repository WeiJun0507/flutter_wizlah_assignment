import 'package:wizlah_assignment/model/movie/movie_review.dart';

class MovieReviewResponse {
  int? id;
  int? page;
  List<MovieReview>? results;
  int? totalPages;
  int? totalResults;

  MovieReviewResponse({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  MovieReviewResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    page = json['page'];
    if (json['results'] != null) {
      results = <MovieReview>[];
      json['results'].forEach((v) {
        results!.add(MovieReview.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
