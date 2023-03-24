import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/route_manager/app_routes.dart';
import '../../../core/style/color_manager.dart';
import '../../controller/auth_cubit/auth_cubit.dart';
import '../../controller/auth_cubit/auth_state.dart';
import '../../widgets/default_form_field.dart';
import '../../widgets/main_button.dart';
import '../../widgets/toast_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorManager.backGround,
        elevation: 0.0,
      ),
      backgroundColor: ColorManager.backGround,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 46.0, horizontal: 32.0),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoginSuccessState ||
                  state is SignInWithGoogleSuccessState) {
                Navigator.pushReplacementNamed(
                    context, AppRoutes.btmNavScreenRoute);
              }
              if (state is LoginErrorState ||
                  state is SignInWithGoogleSuccessState) {
                Components.showToast(
                    message: 'login failed', color: Colors.red);
              }
            },
            builder: (context, state) {
              var cubit = AuthCubit.get(context);
              return Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 34, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      DefaultTextField(
                        controller: _emailController,
                        fNode: _emailFocusNode,
                        // onChanged: value.updateEmail,
                        onComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        inputType: TextInputType.emailAddress,
                        label: 'Email',
                        hint: 'Enter your email',
                        validateMessage: 'Enter valid Email',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      DefaultTextField(
                        controller: _passwordController,
                        fNode: _passwordFocusNode,
                        // onChanged: value.updatePassword,
                        inputType: TextInputType.visiblePassword,
                        label: 'Password',
                        hint: 'Enter your password',
                        validateMessage: 'Enter valid password',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.forgetPasswordScreenRoute);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'forget password?',
                            style: TextStyle(color: ColorManager.primary),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      if (state is LoginLoadingState)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: LinearProgressIndicator(
                            color: ColorManager.primary,
                          ),
                        ),
                      MainButton(
                        text: 'LOGIN',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.userLogin(
                              emailAddress: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          const Text('I have\'t an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.registerScreenRoute);
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: ColorManager.primary,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 130,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Or login with social account',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              await cubit.googleSignInMethod(context: context);
                            },
                            child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.google,
                                  color: ColorManager.primary,
                                )),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {},
                            child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(FontAwesomeIcons.facebookF,
                                    color: ColorManager.primary)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
