import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smart_store/data_layer/models/product_model.dart';

import '../../../../core/global_method.dart';
import '../../../../core/style/color_manager.dart';
import '../../../../data_layer/models/cart_model.dart';
import '../../../controller/cart_cubit/cart_cubit.dart';
import '../../../controller/cart_cubit/cart_state.dart';
import '../../../widgets/text_widget.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    CartModel? cartModel;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 5,
        shadowColor: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image(
                image: NetworkImage(productModel.imageUrl),
                height: 80,
                width: 80,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextWidget(
                      text: productModel.title,
                      color: Colors.black,
                      textSize: 20,
                      maxLines: 2,
                    ),
                  ),
                  RatingBarIndicator(
                    itemSize: 20.0,
                    rating: 4.3,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    direction: Axis.horizontal,
                  ),
                  SizedBox(
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
                  if (!productModel.isDiscount!)
                    Text(
                      '${productModel.price}\$',
                      style: TextStyle(color: ColorManager.primary),
                    ),
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Spacer(),
              BlocConsumer<CartCubit, CartState>(
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
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          _isInCart ? IconlyBold.buy : IconlyLight.buy,
                          size: 28,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
