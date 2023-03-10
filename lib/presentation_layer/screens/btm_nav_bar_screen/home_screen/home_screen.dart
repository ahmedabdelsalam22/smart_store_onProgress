import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_store/presentation_layer/screens/btm_nav_bar_screen/home_screen/view_all_widget.dart';

import '../../../../core/route_manager/app_routes.dart';
import '../../../controller/firestore_cubit/product_cubit/product_cubit.dart';
import '../../../controller/firestore_cubit/product_cubit/product_state.dart';
import 'home_on_sale_list.dart';
import 'home_products_list.dart';
import 'home_swiper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProductCubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                HomeSwiper(),
                const SizedBox(
                  height: 20,
                ),
                ViewAllWidget(
                  title: 'On Sale',
                  subtitle: 'Super summer sale',
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      AppRoutes.viewOnSaleProductsScreenRoute,
                    );
                  },
                ),
                SizedBox(
                  height: size.height * 0.40,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SaleItemBuilder(
                        productModel: cubit.getOnSaleProducts[index],
                      );
                    },
                    itemCount: cubit.getOnSaleProducts.length > 5
                        ? 4
                        : cubit.getOnSaleProducts.length,
                  ),
                ),
                ViewAllWidget(
                  title: 'All Products',
                  subtitle: 'You\'ve never seen it before!',
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      AppRoutes.viewAllProductsScreenRoute,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.40,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return productItemBuilder(
                        productModel: cubit.getProducts[index],
                      );
                    },
                    itemCount: cubit.getProducts.length > 5
                        ? 4
                        : cubit.getProducts.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
