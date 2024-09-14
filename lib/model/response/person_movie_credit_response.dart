import 'package:wizlah_assignment/model/person/person_movie_cast.dart';

class PersonMovieCreditResponse {
  List<PersonMovieCast>? cast;
  int? id;

  PersonMovieCreditResponse({this.cast, this.id});

  PersonMovieCreditResponse.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = <PersonMovieCast>[];
      json['cast'].forEach((v) {
        cast!.add(PersonMovieCast.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cast != null) {
      data['cast'] = cast!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}
