import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_store/presentation_layer/controller/firestore_cubit/firestore_cubit.dart';

import '../../../../core/style/color_manager.dart';
import '../../../controller/firestore_cubit/firestore_state.dart';
import '../../../widgets/back_widget.dart';
import '../view_on_sale_product_screen/view_product_item.dart';

class ViewAllProductScreen extends StatelessWidget {
  const ViewAllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "All Products",
          style: TextStyle(
            color: ColorManager.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<FireStoreCubit, FireStoreState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = FireStoreCubit.get(context);
          return ListView.builder(
            itemBuilder: (context, index) {
              return ViewProductItem(
                productModel: cubit.getProducts[index],
              );
            },
            itemCount: cubit.getProducts.length,
          );
        },
      ),
    );
  }
}
