import 'dart:convert';

import 'package:wizlah_assignment/api/http_util.dart';
import 'package:wizlah_assignment/model/util/common.dart';
import 'package:wizlah_assignment/service/local_storage.dart';

class CommonApi {
  static Future<List<Genre>> getMovieGenre({String language = 'en'}) async {
    final res = await HttpUtil().fetch(
      FetchType.get,
      url: 'genre/movie/list',
      queryParameters: {
        'language': language,
      },
    );

    final genres = Genres.fromJson(res);

    if (genres.genre?.isNotEmpty ?? false) {
      LocalStorageService().prefs.setString(
            LocalStorageService.GENRE,
            jsonEncode(genres.genre),
          );
    }

    return genres.genre ?? [];
  }
}
