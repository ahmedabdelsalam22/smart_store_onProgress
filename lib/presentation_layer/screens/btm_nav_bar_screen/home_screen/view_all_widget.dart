import 'package:flutter/material.dart';

import '../../../../core/style/color_manager.dart';
import '../../../widgets/text_widget.dart';

class ViewAllWidget extends StatelessWidget {
  final String title, subtitle;
  final Function onPressed;

  ViewAllWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: title,
                color: Colors.black,
                textSize: 26,
                isTitle: true,
              ),
              TextWidget(
                text: subtitle,
                color: Colors.grey,
                textSize: 15,
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              onPressed();
            },
            child: TextWidget(
              text: 'view all',
              color: ColorManager.primary,
              textSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
