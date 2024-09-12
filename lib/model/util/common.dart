class Date {
  String? maximum;
  String? minimum;

  Date({this.maximum, this.minimum});

  Date.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maximum'] = maximum;
    data['minimum'] = minimum;
    return data;
  }
}

class Genres {
  List<Genre>? genre;

  Genres({this.genre});

  Genres.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genre = <Genre>[];
      json['genres'].forEach((v) {
        genre!.add(Genre.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (genre != null) {
      data['genres'] = genre!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
