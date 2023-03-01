import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/route_manager/app_routes.dart';
import '../../../core/style/color_manager.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/main_button.dart';
import '../../widgets/text_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackWidget(),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  TextWidget(
                    text: 'Forget Your Password?',
                    color: Colors.black,
                    textSize: 25,
                  ),
                  SizedBox(height: 20),

                  /// TODO : handel this text ..
                  TextWidget(
                    text:
                        "               Don't worry enter your registered \n email to recieve password reset link in your inbox",
                    color: Colors.grey,
                    textSize: 16,
                  ),
                  SizedBox(height: 30),
                  Image.asset(
                    'assets/images/forget_password.GIF',
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    cursorColor: ColorManager.primary,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusColor: ColorManager.primary,
                      labelText: 'Email',
                      labelStyle: TextStyle(color: ColorManager.primary),
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Colors.red,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.primary),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.primary)),
                    ),
                  ),
                  Row(
                    children: [
                      const Text('I remembered password?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.loginScreenRoute);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: ColorManager.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  MainButton(
                    text: 'Send',
                    onTap: () {
                      /// Todo on function
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
