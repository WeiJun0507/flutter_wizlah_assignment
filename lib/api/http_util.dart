import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wizlah_assignment/util/config.dart';

class HttpUtil {
  final DioUtil _dioUtil = DioUtil();

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  HttpUtil._internal();

  //================================= SETTER ===================================
  // void setMainUrl(String url) => _dioUtil.mainUrl = url;
  //
  // void setToken(String token) => _dioUtil.token = 'Bearer $token';

  //================================= REQUEST ==================================
  Future<T> fetch<T>(
    FetchType fetchType, {
    required String url,
    Map<String, String>? queryParameters,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? headers,
    Object? body,
    ResponseType? responseType,
    CancelToken? cancelToken,
    bool authentication = true,
  }) async {
    /// Request Url
    String requestUrl = Config.mainUrl + url;

    /// Request Header
    Map<String, dynamic> effectiveHeaders = <String, dynamic>{};
    if (headers == null) {
      effectiveHeaders = _dioUtil.options.headers;
    } else {
      effectiveHeaders = <String, dynamic>{
        ..._dioUtil.options.headers,
        ...headers
      };
    }

    if (authentication) effectiveHeaders['Authorization'] = Config.token;

    /// Replace Request Url if query parameter is not null
    Uri replacedUri = Uri.parse(requestUrl).replace(
      queryParameters: queryParameters,
    );

    pathParameters?.forEach((String key, String value) {
      if (replacedUri.path.contains(key)) {
        replacedUri = Uri.parse(replacedUri.toString().replaceAll(key, value));
      }
    });

    final Options options = Options(
      headers: effectiveHeaders,
      responseType: responseType,
      receiveDataWhenStatusError: true,
    );

    final Response<T> response = await _getResponse<T>(
      fetchType,
      replacedUri: replacedUri,
      options: options,
      body: body,
      responseType: responseType,
      cancelToken: cancelToken,
      authentication: authentication,
    );
    return response.data!;
  }

  Future<Response<T>> _getResponse<T>(
    FetchType fetchType, {
    required Uri replacedUri,
    required bool authentication,
    required options,
    Object? body,
    ResponseType? responseType,
    CancelToken? cancelToken,
    int retryAttempt = 3,
  }) async {
    try {
      final Response<T> response;
      switch (fetchType) {
        case FetchType.head:
          response = await _dioUtil.dio!.headUri(
            replacedUri,
            data: body,
            options: options,
            cancelToken: cancelToken,
          );
          break;
        case FetchType.get:
          response = await _dioUtil.dio!.getUri(
            replacedUri,
            options: options,
            cancelToken: cancelToken,
          );
          break;
        case FetchType.post:
          response = await _dioUtil.dio!.postUri(
            replacedUri,
            data: body,
            options: options,
            cancelToken: cancelToken,
          );
          break;
        case FetchType.put:
          response = await _dioUtil.dio!.putUri(
            replacedUri,
            data: body,
            options: options,
            cancelToken: cancelToken,
          );
          break;
        case FetchType.patch:
          response = await _dioUtil.dio!.patchUri(
            replacedUri,
            data: body,
            options: options,
            cancelToken: cancelToken,
          );
          break;
        case FetchType.delete:
          response = await _dioUtil.dio!.deleteUri(
            replacedUri,
            data: body,
            options: options,
            cancelToken: cancelToken,
          );
          break;
      }

      return response;
    } catch (e) {
      if (retryAttempt > 0) {
        await Future.delayed(Duration(seconds: (3 - retryAttempt) * 3));
        retryAttempt -= 1;
        return _getResponse<T>(
          fetchType,
          replacedUri: replacedUri,
          options: options,
          body: body,
          responseType: responseType,
          cancelToken: cancelToken,
          authentication: authentication,
          retryAttempt: retryAttempt,
        );
      }

      rethrow;
    }
  }
}

class DioUtil {
  static final DioUtil _instance = DioUtil._init();

  /// Dio 对象
  Dio? _dio;

  /// Dio 配置
  BaseOptions options = getDefOptions();

  /// Domain 网址
  // String mainUrl = '';

  // String token = '';

  //================================= GETTER ===================================
  Dio? get dio => _dio;

  factory DioUtil() {
    return _instance;
  }

  DioUtil._init() {
    _dio = Dio();
    _dio!.options = options;
    _dio!.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: false,
      responseBody: false,
      responseHeader: false,
      error: true,
    ));
  }

  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.connectTimeout = const Duration(seconds: 10);
    options.receiveTimeout = const Duration(seconds: 60);
    options.sendTimeout = const Duration(seconds: 60);

    Map<String, dynamic> headers = <String, dynamic>{};
    headers['Accept'] = 'application/json';
    headers['Content-Type'] = 'application/json';

    options.headers = headers;

    return options;
  }

  //================================= SETTER ===================================
  void setOptions(BaseOptions options) {
    options = options;
    _dio!.options = options;
  }
}

enum FetchType { head, get, post, put, patch, delete }

/*  getError  */
ErrorType getError(dynamic e) {
  if (e is DioException) {
    DioException error = e;
    if (error.type == DioExceptionType.badResponse) {
      /*  Clear user data if error 401  */
      if (error.response?.statusCode == 401) {
        return ErrorType.sessionExpired;
      }
    }
  }

  return getErrorAPI(e);
}

ErrorType getErrorAPI(dynamic e) {
  if (e is DioException) {
    DioException error = e;

    switch (error.type) {
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 500) {
          return ErrorType.serverMaintenance;
        } else {
          return ErrorType.responseError;
        }
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        return ErrorType.timeoutError;
      default:
        if (error.message!.toLowerCase().contains('socket') ||
            error.message!.toLowerCase().contains('network') ||
            error.message!.toLowerCase().contains('server')) {
          return ErrorType.connectionError;
        } else {
          return ErrorType.connectionError;
        }
    }
  } else {
    return ErrorType.responseError;
  }
}

enum ErrorType {
  sessionExpired,
  serverMaintenance,
  responseError,
  connectionError,
  timeoutError
}
