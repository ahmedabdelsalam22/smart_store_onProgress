import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:smart_store/presentation_layer/screens/btm_nav_bar_screen/setting_screen/social_medial.dart';

import '../../../../core/style/color_manager.dart';
import '../../../widgets/text_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                      text: 'Hi,   ',
                      style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'user',
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
                  text: 'user email',
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
                  title: 'Address',
                  subtitle: 'address',
                  icon: IconlyBold.profile,
                  onPressed: () async {
                    /// TODO
                  },
                  color: Colors.black,
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
                _listTiles(
                  title: 'Logout',
                  icon: IconlyBold.logout,
                  color: Colors.black,
                  onPressed: () {
                    ///Navigate to login screen
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
        style: const TextStyle(fontSize: 24),
      ),
      subtitle: TextWidget(
        text: subtitle ?? "",
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
