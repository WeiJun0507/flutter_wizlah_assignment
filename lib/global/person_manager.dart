import 'dart:convert';

import 'package:wizlah_assignment/api/person.dart';
import 'package:wizlah_assignment/global/base_manager.dart';
import 'package:wizlah_assignment/model/person/person_detail.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/model/person/person_movie_cast.dart';
import 'package:wizlah_assignment/service/local_storage_service.dart';

class PersonManager implements BaseManager {
  static final PersonManager _instance = PersonManager._internal();

  factory PersonManager() => _instance;

  PersonManager._internal();

  @override
  void init() async {}

  Future<List<PersonInfo>> getRemotePersonInfo({
    int page = 1,
  }) async {
    final List<PersonInfo> latestPopularList = await PersonApi.getPopularPerson(
      page: page,
    );

    if (page == 1 && latestPopularList.isNotEmpty) {
      LocalStorageService().prefs.setString(
            LocalStorageService.popularPersonList,
            jsonEncode(latestPopularList),
          );
    }

    return latestPopularList;
  }

  Future<PersonDetail?> getRemotePersonDetail(int personId) async {
    return PersonApi.getPersonDetail(personId);
  }

  Future<List<PersonMovieCast>> getRemotePersonMovieCast(int personId) async {
    return PersonApi.getPersonMovieCredits(personId);
  }

  List<PersonInfo> get popularPersonList {
    try {
      final peopleList = LocalStorageService()
          .prefs
          .getString(LocalStorageService.popularPersonList);
      if (peopleList?.isNotEmpty ?? false) {
        return jsonDecode(peopleList!)
            .map<PersonInfo>((e) => PersonInfo.fromJson(e))
            .toList();
      }
    } catch (e) {
      return <PersonInfo>[];
    }

    return <PersonInfo>[];
  }
}
