import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smart_store/data_layer/models/cart_model.dart';
import 'package:smart_store/data_layer/models/product_model.dart';
import 'package:smart_store/presentation_layer/controller/cart_cubit/cart_cubit.dart';
import 'package:smart_store/presentation_layer/controller/cart_cubit/cart_state.dart';

import '../../../../core/global_method.dart';
import '../../../../core/route_manager/app_routes.dart';
import '../../../../core/style/color_manager.dart';

class SaleItemBuilder extends StatelessWidget {
  const SaleItemBuilder({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    CartModel? cartModel;

    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          AppRoutes.productDetailsScreenRoute,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                SizedBox(
                  width: 145,
                  height: 170,
                  child: FancyShimmerImage(
                    imageUrl: productModel.imageUrl,
                    boxFit: BoxFit.scaleDown,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                        child: Text(
                      'on Sale',
                    )),
                  ),
                ),
                Positioned(
                  left: size.width * 0.23,
                  bottom: size.height * 0.011,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.5)),
                        child: Icon(
                          /// TODO toggle icon bold amd light
                          IconlyLight.heart,
                          size: 30,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: size.width * 0.12,
                  bottom: size.height * 0.01,
                  child: BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      var cartCubit = CartCubit.get(context);
                      bool _isInCart =
                          cartCubit.getCartItems.containsKey(productModel.id);
/*
                      final cartList = cartCubit.getCartItems.values
                          .toList()
                          .reversed
                          .toList();*/

                      return InkWell(
                        onTap: () async {
                          /// TODO: FIX ISSUES WHEN REMOVE FROM CART
                          if (_isInCart) {
                            cartCubit.removeOneItem(
                              productId: productModel.id,
                              cartId: cartModel!.id,
                            );
                          } else {
                            await GlobalMethod.addToCart(
                                productId: productModel.id);
                            await cartCubit.getCart();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.5)),
                            child: Icon(
                              _isInCart ? IconlyBold.buy : IconlyLight.buy,
                              size: 30,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            RatingBarIndicator(
              itemSize: 25.0,
              rating: productModel.rate!.toDouble(),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              direction: Axis.horizontal,
            ),
            const SizedBox(
              height: 3,
            ),
            SizedBox(
              width: 145,
              child: Text(
                productModel.title,
                style: const TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              productModel.productCategoryName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            if (productModel.isDiscount!)
              Row(
                children: [
                  Text('${productModel.price}\$',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${productModel.salePrice}\$',
                    style: TextStyle(color: ColorManager.primary),
                  ),
                ],
              ),
            Text(
              '${productModel.salePrice}\$',
              style: TextStyle(color: ColorManager.primary),
            ),
          ],
        ),
      ),
    );
  }
}
