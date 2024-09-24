import 'package:shared_preferences/shared_preferences.dart';
import 'package:wizlah_assignment/service/base_service.dart';

class LocalStorageService implements BaseService {
  static const String genre = 'genre';
  static const String nowPlayingMovieList = 'nowPlayingMovieList';
  static const String upcomingMovieList = 'upcomingMovieList';
  static const String topRatedMovieList = 'topRatedMovieList';
  static const String popularMovieList = 'popularMovieList';

  static const String popularPersonList = 'popularPersonList';

  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  late final SharedPreferences prefs;

  @override
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
