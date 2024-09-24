import 'package:wizlah_assignment/api/http_util.dart';
import 'package:wizlah_assignment/model/util/common.dart';

class CommonApi {
  CommonApi._();

  static Future<List<Genre>> getMovieGenre({String language = 'en'}) async {
    try {
      final res = await HttpUtil().fetch(
        FetchType.get,
        url: 'genre/movie/list',
        queryParameters: {
          'language': language,
        },
      );

      final genres = Genres.fromJson(res);

      return genres.genre ?? <Genre>[];
    } catch (e) {
      return <Genre>[];
    }
  }
}
