import 'package:flutter/material.dart';
import 'package:task_crud/base/widgets/loading_widget.dart';
import 'package:task_crud/core/help_functions.dart';
import 'package:task_crud/features/auth/presentation/manager/auth_provider.dart';
import 'package:task_crud/features/auth/presentation/pages/login_screen.dart';
import 'package:task_crud/features/to_do_list/presentation/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> autoLogin() async {
    final authProvider = context.read<AuthProvider>();
    bool isLogged = await authProvider.autoLogin();
    if (isLogged) {
      navigateAndRemoveUntilTo(const HomeScreen(), context);
    } else {
      navigateAndRemoveUntilTo(const LoginScreen(), context);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      autoLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: LoadingWidget()),
    );
  }
}
