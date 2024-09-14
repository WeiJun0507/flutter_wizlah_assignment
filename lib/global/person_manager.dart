import 'dart:convert';

import 'package:wizlah_assignment/api/person.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/service/local_storage_service.dart';

class PersonManager {
  static final PersonManager _instance = PersonManager._internal();

  factory PersonManager() => _instance;

  PersonManager._internal();

  void init() async {}

  Future<List<PersonInfo>> getRemotePersonInfo({
    int page = 1,
  }) async {
    List<PersonInfo> latestPopularList = await PersonApi.getPopularPerson(
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

  List<PersonInfo> get popularPersonList {
    final peopleList = LocalStorageService()
        .prefs
        .getString(LocalStorageService.popularPersonList);
    if (peopleList?.isNotEmpty ?? false) {
      return jsonDecode(peopleList!)
          .map<PersonInfo>((e) => PersonInfo.fromJson(e))
          .toList();
    }

    return <PersonInfo>[];
  }
}
