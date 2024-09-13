import 'package:wizlah_assignment/model/person/person_info.dart';

class PersonListResponse {
  int? page;
  List<PersonInfo>? results;
  int? totalPages;
  int? totalResults;

  PersonListResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  PersonListResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <PersonInfo>[];
      json['results'].forEach((v) {
        results!.add(PersonInfo.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
