import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String genre = 'genre';
  static const String nowPlayingMovieList = 'nowPlayingMovieList';
  static const String upcomingMovieList = 'upcomingMovieList';
  static const String topRatedMovieList = 'topRatedMovieList';
  static const String popularMovieList = 'popularMovieList';

  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  late final SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
