import 'package:flutter/material.dart';
import 'package:smart_store/presentation_layer/widgets/text_widget.dart';

import '../../core/style/color_manager.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    Key? key,
    required this.imPath,
    required this.title,
    required this.buttonText,
  }) : super(key: key);

  final String imPath, title, buttonText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                imPath,
                width: size.height,
                height: size.height * 0.4,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'whoops',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                  text: title, color: ColorManager.primary, textSize: 20),
            ],
          ),
        ),
      ),
    );
  }
}
