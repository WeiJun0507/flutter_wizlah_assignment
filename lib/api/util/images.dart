import 'package:wizlah_assignment/util/config.dart';

class Images {
  static const String _baseUrl = Config.resourceUrl;

  static const String original = 'original';

  //Poster Sizes
  static const String posterSmallest = 'w92';
  static const String posterMedium = 'w342';
  static const String posterHighest = 'w500';

  // Logo Sizes
  static const String logoSmallest = 'w92';
  static const String logoMedium = 'w300';
  static const String logoHighest = 'w500';

  // Backdrop Size
  static const String backdropSmallest = 'w185';
  static const String backdropMedium = 'w300';
  static const String backdropHighest = 'w780';

  // profile size
  static const String profileSmallest = 'w45';
  static const String profileMedium = 'w185';
  static const String profileHighest = 'h632';

  Images._();

  static String getUrl(
    String? imagePath, {
    String size = original,
  }) {
    return '$_baseUrl/$size/$imagePath';
  }
}
