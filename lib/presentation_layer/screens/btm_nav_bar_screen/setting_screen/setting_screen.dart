import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:smart_store/presentation_layer/screens/btm_nav_bar_screen/setting_screen/social_medial.dart';

import '../../../../core/route_manager/app_routes.dart';
import '../../../../core/style/color_manager.dart';
import '../../../controller/auth_cubit/auth_cubit.dart';
import '../../../controller/auth_cubit/auth_state.dart';
import '../../../widgets/text_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: TextWidget(
            text: 'Setting',
            color: ColorManager.primary,
            textSize: 22,
            isTitle: true,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Welcome',
                      style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: user!.displayName == null
                                ? ""
                                : user.displayName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.normal),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('my name is pressed');
                              }),
                      ]),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: user.email == null ? "no user login" : "${user.email}",
                  color: Colors.black,
                  textSize: 18,
                  // isTitle: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                _listTiles(
                    title: 'Technical support',
                    icon: Icons.help,
                    color: Colors.black,
                    onPressed: () {
                      ///Navigate to Technical support
                    }),
                _listTiles(
                    title: 'Call us',
                    icon: Icons.call,
                    color: Colors.black,
                    onPressed: () {
                      _callNumber();
                    }),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is SignOutSuccessState)
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed(AppRoutes.loginScreenRoute);

                    /// TODO: this issue
                  },
                  builder: (context, state) {
                    var cubit = AuthCubit.get(context);
                    return _listTiles(
                      title: 'Logout',
                      icon: IconlyBold.logout,
                      color: Colors.black,
                      onPressed: () {
                        cubit.signOut();
                      },
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                TextWidget(
                  text: 'Follow us',
                  color: Colors.blue,
                  textSize: 18,
                ),
                const SizedBox(
                  height: 20,
                ),
                SocialMedia(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //

  _callNumber() async {
    const number = '01113046200'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  Widget _listTiles(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed,
      required Color color}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 19),
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
