import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/style/color_manager.dart';
import '../../../controller/firestore_cubit/product_cubit/product_cubit.dart';
import '../../../controller/firestore_cubit/product_cubit/product_state.dart';
import '../../../widgets/back_widget.dart';
import 'view_product_item.dart';

class ViewAllOnSaleProductsScreen extends StatelessWidget {
  const ViewAllOnSaleProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "OnSale Products",
          style: TextStyle(
            color: ColorManager.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ProductCubit.get(context);
          return ListView.builder(
            itemBuilder: (context, index) {
              return ViewProductItem(
                productModel: cubit.getOnSaleProducts[index],
              );
            },
            itemCount: cubit.getOnSaleProducts.length > 5
                ? 4
                : cubit.getOnSaleProducts.length,
          );
        },
      ),
    );
  }
}
