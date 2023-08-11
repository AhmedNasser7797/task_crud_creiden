import 'package:task_crud/features/auth/data/models/user_model.dart';

import '../data_sources/auth_api_data_source.dart';

class BaseAuthRepository {
  //Singleton
  BaseAuthRepository._();
  static final BaseAuthRepository instance = BaseAuthRepository._();
  final ApiAuthService apiAuthService = ApiAuthService.instance;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    return await apiAuthService.login(
      email: email,
      pass: password,
    );
  }
}
