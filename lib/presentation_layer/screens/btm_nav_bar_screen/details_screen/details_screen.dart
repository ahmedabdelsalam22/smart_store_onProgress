import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/global_method.dart';
import '../../../../core/style/color_manager.dart';
import '../../../../data_layer/models/cart_model.dart';
import '../../../../data_layer/models/product_model.dart';
import '../../../controller/cart_cubit/cart_cubit.dart';
import '../../../controller/cart_cubit/cart_state.dart';
import '../../../widgets/main_button.dart';
import 'drop_down_menu.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailsScreen({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    CartModel? cartModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          productModel.title,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: ColorManager.primary),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.primary,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(
              productModel.imageUrl,
            ),
            height: size.height * 0.3,
            width: double.infinity,
            fit: BoxFit.scaleDown,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: DropDownMenuComponent(
                    hint: 'Size',
                    onChanged: (String? value) {
                      // TODO HANDLE PRODUCT SIZE
                    },
                    items: const ['S', 'M', 'L', 'XL', 'XXL'],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    //TODO Payment Integration process
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.credit_card,
                        size: 30,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productModel.productCategoryName,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: ColorManager.primary),
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
                    '${productModel.salePrice}\$',
                    style: TextStyle(color: ColorManager.primary),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
            child: Text(
              productModel.title,
              maxLines: 2,
              style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 20),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
            child: Text(
              productModel.details,
              maxLines: 5,
              style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: RatingBarIndicator(
                itemSize: 25.0,
                rating: productModel.rate!.toDouble(),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                direction: Axis.horizontal,
              ),
            ),
          ),
          const Spacer(),
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

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: MainButton(
                  text: _isInCart ? 'Already in cart' : 'Add To Cart',
                  onTap: () async {
                    /// TODO: FIX ISSUES WHEN REMOVE FROM CART
                    if (_isInCart) {
                      cartCubit.removeOneItem(
                        productId: productModel.id,
                        cartId: cartModel!.id,
                      );
                    } else {
                      await GlobalMethod.addToCart(productId: productModel.id);
                      await cartCubit.getCart();
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
