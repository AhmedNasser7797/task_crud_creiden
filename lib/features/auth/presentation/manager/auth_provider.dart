import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_crud/core/help_functions.dart';
import 'package:task_crud/core/hive_helper.dart';
import 'package:task_crud/features/auth/data/models/user_model.dart';
import 'package:task_crud/features/auth/data/repositories/base_auth_repository.dart';

import '/core/extension_methods/dio_error_extensions.dart';
import '../../../../core/constants/database_variable.dart';

export 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  final BaseAuthRepository _baseAuthRepository = BaseAuthRepository.instance;

  final HiveHelper _hiveHelper = HiveHelper.instance;

  UserModel currentUser = UserModel();

  bool get authLogged => currentUser.id.isNotEmpty;

  Future<bool> autoLogin() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (authLogged) {
      return true;
    }

    //2- second condition if user logged in before
    bool isLoggedIn =
        _hiveHelper.getStringFromAuth(DatabaseVariables().token) != null;

    if (!isLoggedIn) {
      return false;
    }

    try {
      await getUserInfo();

      return true;
    } on SocketException catch (e, s) {
      error(e, s, hint: e.toString());
      return false;
    } on DioException catch (e, s) {
      error(e, s, hint: e.readableError);
      return false;
    } catch (e, s) {
      error(e, s, hint: e.toString());

      return false;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    currentUser = await _baseAuthRepository.login(
      email: email,
      password: password,
    );
    notifyListeners();
  }

  Future<void> getUserInfo() async {}
}
