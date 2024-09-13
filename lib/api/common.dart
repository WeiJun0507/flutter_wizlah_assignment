import 'package:wizlah_assignment/api/http_util.dart';
import 'package:wizlah_assignment/model/util/common.dart';

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

    return genres.genre ?? [];
  }
}
