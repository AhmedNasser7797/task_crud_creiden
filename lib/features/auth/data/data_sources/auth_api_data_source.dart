import 'dart:async';
import 'dart:convert';

import 'package:task_crud/core/api_provider.dart';
import 'package:task_crud/features/auth/data/models/user_model.dart';

import '/core/constants/database_variable.dart';
import '/core/hive_helper.dart';
import '../../../../../core/constants/server_constants.dart';

class ApiAuthService {
  //Singleton
  ApiAuthService._();
  static final ApiAuthService instance = ApiAuthService._();

  final ServerConstants _serverConstants = ServerConstants.instance;

  final ApiProvider _dio = ApiProvider.internal();
  final HiveHelper _hiveHelper = HiveHelper.instance;
  final DatabaseVariables _databaseVariables = DatabaseVariables.instance;

  ////////////////////////////////////////////////////////////////////////////////
////////////////////////////// END POINTS //////////////////////////////////////

  Future<UserModel> login({
    required String email,
    required String pass,
  }) async {
    // Request
    var data = {
      "email": email.trim(),
      "password": pass,
    };
    final response = await _dio.post(
      _serverConstants.loginEndPoint,
      data: jsonEncode(data),
    );
    if (_dio.validResponse(response.statusCode)) {
      await saveToken(response.data['data'][_databaseVariables.token]);
      return UserModel.fromJson(response.data['data']['user']);
    } else {
      // Err
      throw response.data ?? response.statusMessage ?? "";
    }
  }

////////////////////////////////// UTILS ///////////////////////////////////////
}

Future<void> saveToken(String? token) async {
  final HiveHelper hiveHelper = HiveHelper.instance;
  final DatabaseVariables databaseVariables = DatabaseVariables.instance;
  await hiveHelper.saveStringAboutAuth(
    databaseVariables.token,
    "Bearer $token",
  );
}
