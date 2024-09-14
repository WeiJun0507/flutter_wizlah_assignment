import 'package:wizlah_assignment/api/http_util.dart';
import 'package:wizlah_assignment/model/person/person_detail.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/model/person/person_movie_cast.dart';
import 'package:wizlah_assignment/model/response/person_list_response.dart';
import 'package:wizlah_assignment/model/response/person_movie_credit_response.dart';

class PersonApi {
  static const String _prefix = 'person';

  // get movie upcoming list
  static Future<List<PersonInfo>> getPopularPerson({
    String language = 'en-US',
    int page = 1,
  }) async {
    String urlPath = '$_prefix/popular';

    final res = await HttpUtil().fetch(
      FetchType.get,
      url: urlPath,
      queryParameters: {
        'language': language,
        'page': page.toString(),
      },
    );

    return PersonListResponse.fromJson(res).results ?? [];
  }

  static Future<PersonDetail?> getPersonDetail(int personId) async {
    String urlPath = '$_prefix/$personId';

    try {
      final res = await HttpUtil().fetch(FetchType.get, url: urlPath);

      return PersonDetail.fromJson(res);
    } catch (e) {
      return null;
    }
  }

  static Future<List<PersonMovieCast>> getPersonMovieCredits(
    int personId, {
    String language = 'en-US',
  }) async {
    String urlPath = '$_prefix/$personId/movie_credits';

    final res =
        await HttpUtil().fetch(FetchType.get, url: urlPath, queryParameters: {
      'language': language,
    });

    return PersonMovieCreditResponse.fromJson(res).cast ?? [];
  }
}
