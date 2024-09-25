import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wizlah_assignment/api/http_util.dart';

void main() {
  group('Check environment configuration setting.', () {
    const String domain = String.fromEnvironment('domain');
    const String resourceDomain = String.fromEnvironment('resource_domain');
    const String credential = String.fromEnvironment('credential');
    test('Check request domain is not empty', () {
      expect(domain.isNotEmpty, true);
    });

    test('Check resource domain is not empty', () {
      expect(resourceDomain.isNotEmpty, true);
    });

    test('Check request credential is not empty', () {
      expect(credential.isNotEmpty, true);
    });

    test('Check request credential is valid', () async {
      String urlPath = 'movie/now_playing';

      final DioUtil dioUtil = DioUtil();

      /// Request Url
      String requestUrl = domain + urlPath;

      /// Request Header
      Map<String, dynamic> effectiveHeaders = <String, dynamic>{};
      effectiveHeaders = dioUtil.options.headers;
      effectiveHeaders['Authorization'] = credential;

      /// Replace Request Url if query parameter is not null
      Uri replacedUri = Uri.parse(requestUrl).replace(
        queryParameters: {
          'language': 'en-US',
          'page': '1',
        },
      );

      final Options options = Options(
        headers: effectiveHeaders,
        receiveDataWhenStatusError: true,
      );

      final response = await dioUtil.dio!.getUri(replacedUri, options: options);

      expect(response.statusCode, 200);
    });
  });
}
