import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:task_crud/base/splash_screen.dart';

import 'core/constants/vars.dart';
import 'core/hive_helper.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/manager/auth_provider.dart';
import 'features/to_do_list/presentation/manager/todo_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.instance.init();
  runApp(const TaskCRUD());
}

class TaskCRUD extends StatelessWidget {
  const TaskCRUD({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<TodoProvider>(create: (_) => TodoProvider()),
      ],
      child: MaterialApp(
        title: 'Task CRUD',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().lightTheme,
        home: const SplashScreen(),
        navigatorKey: navigatorKey,
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 400,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
      ),
    );
  }
}
