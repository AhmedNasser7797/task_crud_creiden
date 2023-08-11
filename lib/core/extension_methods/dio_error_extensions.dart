import 'package:dio/dio.dart';

export 'package:dio/dio.dart';

extension DioErrorExtensions on DioException {
  bool get is401 => response?.statusCode == 401;

  bool get is500 => response?.statusCode == 500;
  String get readableError {
    // No Response ? then No Server...
    if (response?.data == null) {
      return "Server Error";
    } //
    if (is500) {
      return "Server Error";
    }

    // if response is String .. ex: 404

    else if (response?.data is Map<String, dynamic>) {
      if (response?.data['message'] != null) {
        return response?.data['message'];
      } else if (response?.data['error'] != null &&
          response?.data['error'].runtimeType == String) {
        return response?.data['error'];
      } else if (response?.data['error']['message'].runtimeType == String) {
        return response?.data['error']['message'];
      } else if (response?.data['error']['message'] != null) {
        var error = response?.data['error']['message'];
        return error;
      }
    }

    return "Server Error";
  }
}
