import 'package:dio/dio.dart';

class NetworkExceptionHandler<E> {
  E exception;
  NetworkExceptionHandler(this.exception);
  @override
  String toString() {
    // return 'test';
    if (exception is DioException) {
      return (exception as DioException).toErrorString();
    } else {
      return 'unknown error';
    }
  }
}

extension _DioExceptionExtension on DioException {
  String toErrorString() =>
      response != null ? response?.data['message'] : type.toPrettyDescription();
}

extension _DioExceptionTypeExtension on DioExceptionType {
  String toPrettyDescription() {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return 'connection timeout';
      case DioExceptionType.sendTimeout:
        return 'send timeout';
      case DioExceptionType.receiveTimeout:
        return 'receive timeout';
      case DioExceptionType.badCertificate:
        return 'bad certificate';
      case DioExceptionType.badResponse:
        return 'bad response';
      case DioExceptionType.cancel:
        return 'request cancelled';
      case DioExceptionType.connectionError:
        return 'connection error';
      case DioExceptionType.unknown:
        return 'unknown';
    }
  }
}
