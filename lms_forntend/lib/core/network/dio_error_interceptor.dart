import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onerror(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      if (err.response!.statusCode! >= 300) {
        err = DioException(
            requestOptions: err.requestOptions,
            response: err.response,
            type: err.type,
            error:
                err.response!.data['message'] ?? err.response!.statusMessage);
      } else {
        err = DioException(
            requestOptions: err.requestOptions,
            response: err.response,
            error: 'Something Went Wrong',
            type: err.type);
      }
    } else {
      // Handle connection error
      err = DioException(
        requestOptions: err.requestOptions,
        error: 'Connection error',
        type: err.type,
      );
    }
    super.onError(err, handler);
  }
}
