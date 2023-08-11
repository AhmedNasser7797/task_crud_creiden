import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'constants/database_variable.dart';
import 'constants/server_constants.dart';
import 'hive_helper.dart';

class ApiProvider {
// next three lines makes this class a Singleton
  static final ApiProvider _instance = ApiProvider.internal();

  ApiProvider.internal();

  factory ApiProvider() => _instance;
  final HiveHelper _hiveHelper = HiveHelper.instance;
  final DatabaseVariables _databaseVariables = DatabaseVariables.instance;
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: ServerConstants.apiBase,
      headers: apiHeaders,
    ),
  )..interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

  static Map<String, String> apiHeaders = <String, String>{
    HttpHeaders.contentTypeHeader: "application/json",
    "Accept": "application/json",
  };
  String? get token => _hiveHelper.getStringFromAuth(_databaseVariables.token);
  // Validating Request.
  bool validResponse(int? statusCode) {
    if (statusCode == null) {
      return false;
    } else {
      return (statusCode >= 200 && statusCode < 300);
    }
  }

  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(
        contentType: 'application/json',
        // followRedirects: false,
        // validateStatus: (status) {
        //   return status! < 500;
        // },
        headers: {
          ...apiHeaders,
          "Authorization": token,
        },
      ),
    );
    if (validResponse(response.statusCode)) {
      return response;
    } else {
      throw response.data ?? response.statusMessage ?? "";
    }
  }

  Future<Response<dynamic>> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, String?>? headers,
  }) async {
    log(HiveHelper.instance
        .getStringFromAuth(DatabaseVariables().token)
        .toString());
    final response = await dio.post(
      url,
      queryParameters: queryParameters,
      data: data,
      options: Options(
        headers: {
          ...apiHeaders,
          "Authorization": token,
        },
      ),
    );
    return response;
  }
}
