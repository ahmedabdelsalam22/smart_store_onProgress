import 'package:flutter/material.dart';
import 'package:smart_store/presentation_layer/widgets/text_widget.dart';

import '../../core/style/color_manager.dart';

class CheckOutWidget extends StatelessWidget {
  const CheckOutWidget({Key? key, required this.price}) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.1,
        child: Row(
          children: [
            Material(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(10),
              child: TextButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const Spacer(),
            FittedBox(
              child: TextWidget(
                text: 'Total : \$${price.toStringAsFixed(2)}',
                color: Colors.black,
                textSize: 18,
                isTitle: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
