import 'package:wizlah_assignment/model/person/person_info.dart';

class MovieCastResponse {
  int? id;
  List<PersonInfo>? cast;

  // crew do not required

  MovieCastResponse({
    this.id,
    this.cast,
  });

  MovieCastResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = <PersonInfo>[];
      json['cast'].forEach((v) {
        cast!.add(PersonInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (cast != null) {
      data['cast'] = cast!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
