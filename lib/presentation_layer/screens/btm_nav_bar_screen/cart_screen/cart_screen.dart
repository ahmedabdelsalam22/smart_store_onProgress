import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../../core/style/color_manager.dart';
import '../../../widgets/check_out_widget.dart';
import '../../../widgets/global_methode.dart';
import '../../../widgets/text_widget.dart';
import 'cart_list_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backGround,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: ColorManager.backGround,
        title: TextWidget(
          text: 'Cart(7)',
          color: ColorManager.primary,
          textSize: 22,
          isTitle: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              GlobalMethode.warningDialog(
                title: 'Empty your cart',
                subtitle: 'Are you sure?',
                fct: () async {},
                context: context,
              );
            },
            icon: Icon(
              IconlyBroken.delete,
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          CheckOutWidget(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return CartListItemWidget();
              },
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}