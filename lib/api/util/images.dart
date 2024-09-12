import 'package:wizlah_assignment/util/config.dart';

class Images {
  final String _baseUrl = Config.resourceUrl;

  static const String ORIGINAL = 'original';

  //Poster Sizes
  static const String POSTER_SIZE_LOWEST = 'w92';
  static const String POSTER_SIZE_LOW = 'w154';
  static const String POSTER_SIZE_MEDIUM = 'w185';
  static const String POSTER_SIZE_MEDIUMPLUS = 'w342';
  static const String POSTER_SIZE_HIGH = 'w500';
  static const String POSTER_SIZE_HIGHEST = 'w780';

  // Logo Sizes
  static const String LOGO_SIZE_LOWEST = 'w45';
  static const String LOGO_SIZE_LOW = 'w92';
  static const String LOGO_SIZE_MEDIUM = 'w154';
  static const String LOGO_SIZE_MEDIUMPLUS = 'w185';
  static const String LOGO_SIZE_HIGH = 'w300';
  static const String LOGO_SIZE_HIGHEST = 'w500';

  // Backdrop Size
  static const String BACKDROP_SIZE_LOWEST = 'w300';
  static const String BACKDROP_SIZE_MEDIUM = 'w185';
  static const String BACKDROP_SIZE_HIGHEST = 'w780';

  // profile size
  static const String PROFILE_SIZE_LOWEST = 'w45';
  static const String PROFILE_SIZE_MEDIUM = 'w185';
  static const String PROFILE_SIZE_HIGHEST = 'w632';

  // still size
  static const String STILL_SIZE_LOWEST = 'w92';
  static const String STILL_SIZE_MEDIUM = 'w185';
  static const String STILL_SIZE_HIGHEST = 'w300';

  String? getUrl(
    String? imagePath, {
    String size = ORIGINAL,
  }) {
    return '$_baseUrl/$size/$imagePath';
  }
}
