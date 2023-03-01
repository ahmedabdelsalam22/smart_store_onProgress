import 'package:flutter/material.dart';

import '../../../widgets/text_widget.dart';

class CustomTabBarBtn extends StatelessWidget {
  const CustomTabBarBtn({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return TextWidget(text: title, color: Colors.black, textSize: 15.0);
  }
}
