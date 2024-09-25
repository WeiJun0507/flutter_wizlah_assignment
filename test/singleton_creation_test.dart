import 'package:flutter_test/flutter_test.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/service/local_storage_service.dart';

void main() {
  group('Test singleton services', () {
    test('Test App Service singleton', () {
      final appS1 = AppService();
      final appS2 = AppService();

      expect(appS1.hashCode, appS2.hashCode);
    });

    test('Test Local Storage Service singleton', () {
      final localStorageS1 = LocalStorageService();
      final localStorageS2 = LocalStorageService();

      expect(localStorageS1.hashCode, localStorageS2.hashCode);
    });
  });
}
