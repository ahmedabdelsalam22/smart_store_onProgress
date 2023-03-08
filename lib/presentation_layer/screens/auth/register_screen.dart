import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/route_manager/app_routes.dart';
import '../../../core/style/color_manager.dart';
import '../../controller/auth_cubit/auth_cubit.dart';
import '../../controller/auth_cubit/auth_state.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/default_form_field.dart';
import '../../widgets/main_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackWidget(),
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
              if (state is verifyEmailSuccessState)
                //  if (state is RegisterSuccessState)
                Navigator.pushNamed(context, AppRoutes.btmNavScreenRoute);
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
                        'Register',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 34, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      DefaultTextField(
                        controller: _nameController,
                        fNode: _nameFocusNode,
                        onComplete: () => FocusScope.of(context)
                            .requestFocus(_emailFocusNode),
                        inputType: TextInputType.name,
                        label: 'Name',
                        hint: 'Enter your Name',
                        validateMessage: 'Enter valid Name',
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DefaultTextField(
                        controller: _emailController,
                        fNode: _emailFocusNode,
                        onComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        inputType: TextInputType.emailAddress,
                        label: 'Email',
                        hint: 'Enter your email',
                        validateMessage: 'Enter valid Email',
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DefaultTextField(
                        controller: _passwordController,
                        fNode: _passwordFocusNode,
                        inputType: TextInputType.visiblePassword,
                        label: 'Password',
                        hint: 'Enter your password',
                        validateMessage: 'Enter valid password',
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        children: [
                          const Text('I already have an account?'),
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
                      const SizedBox(
                        height: 25.0,
                      ),
                      if (state is RegisterLoadingState)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: LinearProgressIndicator(
                            color: ColorManager.primary,
                          ),
                        ),
                      MainButton(
                        text: 'SIGN UP',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.userRegister(
                                name: _nameController.text,
                                emailAddress: _emailController.text,
                                password: _passwordController.text);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 110,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Or sign up with social account',
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
                            onTap: () {},
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
