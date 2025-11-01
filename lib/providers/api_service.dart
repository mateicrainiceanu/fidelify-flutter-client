
import "package:dio/dio.dart";
import "package:fidelify_client/utils/logger.dart";

import "auth_user_provider.dart";

enum DioMethods { get, post, put, patch, delete }

enum NetworkStatus { ok, error }

class NetworkError {
  int code = 0;
  String message = "";

  NetworkError({required this.code, required this.message});
}

class RequestResponse<T> {
  late final T? val;
  late final NetworkError? error;
  final NetworkStatus status;

  RequestResponse({
    this.val,
    this.error,
    required this.status,
  });

  factory RequestResponse.success(T data) =>
      RequestResponse(val: data, status: NetworkStatus.ok);

  factory RequestResponse.failure(NetworkError error) =>
      RequestResponse(error: error, status: NetworkStatus.error);
}

class AuthInterceptor extends Interceptor {
  final AuthUserProvider authUserProvider;

  AuthInterceptor(this.authUserProvider);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = authUserProvider.token;

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      Log.trace('AuthInterceptor, ApiService --> Interceptor: Added Bearer token to headers'); // For debugging
    }

    super.onRequest(options, handler);
  }
}

class ApiService {

  late Dio _dio;
  static final ApiService instance = ApiService._internal();

  ApiService._internal() {
    _dio = Dio(
        BaseOptions(
          baseUrl: "http://10.0.2.2:3000",
          contentType: Headers.jsonContentType,
        )
    );

  }

  void attachAuthProvider(AuthUserProvider provider) {
    _dio.interceptors.clear();
    _dio.interceptors.add(AuthInterceptor(provider));
  }

  // ✨ Public GET method
  Future<RequestResponse<T>> get<T>({
    required String path,
    Map<String, dynamic>? params,
    T Function(Map<String, dynamic>)? parser,
  }) async {
    return _request<T>(
      path: path,
      method: DioMethods.get,
      params: params,
      parser: parser,
    );
  }

  // ✨ Public POST method
  Future<RequestResponse<T>> post<T>({
    required String path,
    Map<String, dynamic>? params,
    dynamic data,
    T Function(Map<String, dynamic>)? parser,
  }) async {
    return _request<T>(
      path: path,
      method: DioMethods.post,
      params: params,
      data: data,
      parser: parser,
    );
  }

  // ✨ Public PUT method
  Future<RequestResponse<T>> put<T>({
    required String path,
    Map<String, dynamic>? params,
    dynamic data,
    T Function(Map<String, dynamic>)? parser,
  }) async {
    return _request<T>(
      path: path,
      method: DioMethods.put,
      params: params,
      data: data,
      parser: parser,
    );
  }

  // 🚀 Generic request handler
  Future<RequestResponse<T>> _request<T>({
    required String path,
    required DioMethods method,
    Map<String, dynamic>? params,
    dynamic data,
    T Function(Map<String, dynamic>)? parser,
  }) async {
    Log.trace("ApiService._request: ${method.name}: ${path}");
    try {
      Response response;
      switch (method) {
        case DioMethods.get:
          response = await _dio.get(path, queryParameters: params);
          break;
        case DioMethods.post:
          response = await _dio.post(path, queryParameters: params, data: data);
          break;
        case DioMethods.put:
          response = await _dio.put(path, queryParameters: params, data: data);
          break;
        case DioMethods.patch:
          response = await _dio.patch(path, queryParameters: params, data: data);
          break;
        case DioMethods.delete:
          response = await _dio.delete(path, queryParameters: params, data: data);
          break;
      }
      Log.trace("ApiService._request: ${method.name}: ${path} -> Success ${response.statusCode}");
      return _handleResponse<T>(response, parser);
    } catch (error) {
      Log.trace("ApiService._request: ${method.name}: ${path} -> Error ${error.toString()}");
      return _handleError<T>(error);
    }
  }


  // 🔹 Common response handler
  RequestResponse<T> _handleResponse<T>(
      Response response,
      T Function(Map<String, dynamic>)? parser,
      ) {
    Log.trace("ApiService._handleResponse: ${response.statusCode}");
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      Log.trace("ApiService._handleResponse [${response.statusCode}] -> ${response.data.toString()}");
      final data = parser != null ? parser(response.data) : response.data as T;
      return RequestResponse.success(data);
    } else {
      Log.error("ApiService._handleResponse: with code != 2xx -> ${response.statusCode}: ${response.statusMessage}");
      return RequestResponse.failure(
        NetworkError(
          code: response.statusCode ?? 0,
          message: response.statusMessage ?? "Unknown error",
        ),
      );
    }
  }

  // 🔹 Common error handler
  RequestResponse<T> _handleError<T>(Object error) {
    if (error is DioException) {

      final errorMsg = error.response?.data['error'] ?? "Network error";
      final statusCode = error.response?.statusCode ?? 0;

      Log.error("ApiService._handleError DioEx -> ${statusCode}: ${errorMsg} --> ${error.response?.toString()}");

      return RequestResponse.failure(
        NetworkError(
          code: statusCode,
          message: errorMsg,
        ),
      );
    } else {
      Log.error("ApiService._handleError != DioEx -> ${error.toString()} ${error.runtimeType}");
      return RequestResponse.failure(
        NetworkError(code: 0, message: error.toString()),
      );
    }
  }

}