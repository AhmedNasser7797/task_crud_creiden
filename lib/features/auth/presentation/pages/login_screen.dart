import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_crud/base/widgets/login_simple_textfield.dart';
import 'package:task_crud/features/to_do_list/presentation/pages/home_screen.dart';

import '/core/extension_methods/dio_error_extensions.dart';
import '/core/theme/theme_data.dart';
import '../../../../base/widgets/custom_button.dart';
import '../../../../base/widgets/loading_widget.dart';
import '../manager/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  bool isSecure = true;
  String email = "";
  String pass = "";

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      if (!autoValidate) setState(() => autoValidate = true);
      return;
    }
    _formKey.currentState?.save();
    try {
      LoadingScreen.show(context);
      final auth = context.read<AuthProvider>();
      await auth.login(email: email, password: pass);
      navigateAndRemoveUntilTo(const HomeScreen(), context);
    } on DioException catch (e, s) {
      Navigator.pop(context);
      showErrorDialog(e.readableError, context);
      error(e, s);
    } catch (e, s) {
      Navigator.pop(context);
      error(e, s);
      showErrorDialog(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: ,
          //       color: Color(0x66FE1E9A).withOpacity(0.9),
          //       ),
          // ),
          Container(
            padding: EdgeInsets.only(
                top: getSize(context).height * 0.2, right: 26, left: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Login",
                  style: titleStyle(context)?.copyWith(
                    fontSize: 32,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: getSize(context).height * 0.6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: cardColor(context),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  blurRadius: 25,
                  offset: Offset(0, -3),
                )
              ],
            ),
            margin: EdgeInsets.only(
              top: getSize(context).height * 0.4,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                autovalidateMode: autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 42),
                    LoginSimpleTextField(
                      initialValue: kDebugMode ? "flutter-task@test.com" : "",
                      onSaved: (v) => email = v!,
                      hintText: "Enter Your Email",
                      label: "Email *",
                      textInputType: TextInputType.emailAddress,
                      validationError: Validator(
                        rules: [
                          requireRule(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    LoginSimpleTextField(
                      initialValue: kDebugMode ? "12345678" : "",
                      onSaved: (v) => pass = v!,
                      hintText: "Enter Your Password",
                      label: "Password *",
                      obSecure: isSecure,
                      validationError: Validator(
                        rules: [
                          requireRule(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    CustomButton(
                      onTap: login,
                      title: 'login',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
