import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String GENRE = 'genre';

  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  late final SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
