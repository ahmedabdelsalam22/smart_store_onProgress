import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/route_manager/app_routes.dart';
import '../../../../core/style/color_manager.dart';
import '../../../../data_layer/models/cart_model.dart';
import '../../../controller/cart_cubit/cart_cubit.dart';
import '../../../controller/firestore_cubit/product_cubit/product_cubit.dart';
import '../../../widgets/text_widget.dart';

class CartListItemWidget extends StatelessWidget {
  const CartListItemWidget(
      {Key? key, required this.cartList, required this.cubit})
      : super(key: key);

  final CartModel cartList;
  final CartCubit cubit;

  @override
  Widget build(BuildContext context) {
    var productProvider = BlocProvider.of<ProductCubit>(context);

    final getCurrentProduct =
        productProvider.findProductById(cartList.productId);

    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
            AppRoutes.productDetailsScreenRoute,
            arguments: getCurrentProduct);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Material(
          elevation: 5,
          shadowColor: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    Image(
                      image: NetworkImage(getCurrentProduct.imageUrl),
                      height: 80,
                      width: 80,
                      fit: BoxFit.scaleDown,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
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
                  ],
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
                        text: getCurrentProduct.title,
                        color: Colors.black,
                        textSize: 20,
                        maxLines: 2,
                      ),
                    ),
                    TextWidget(
                      text: getCurrentProduct.productCategoryName,
                      color: Colors.grey,
                      textSize: 15,
                    ),
                    RatingBarIndicator(
                      itemSize: 20.0,
                      rating: 4.4,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      direction: Axis.horizontal,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (getCurrentProduct.isDiscount!)
                      Row(
                        children: [
                          Text('${getCurrentProduct.price}\$',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${getCurrentProduct.salePrice}\$',
                            style: TextStyle(color: ColorManager.primary),
                          ),
                        ],
                      ),
                    if (!getCurrentProduct.isDiscount!)
                      Text(
                        '${getCurrentProduct.salePrice}\$',
                        style: TextStyle(color: ColorManager.primary),
                      ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    cubit.removeOneItem(
                        productId: cartList.productId, cartId: cartList.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        IconlyLight.delete,
                        size: 26,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.5,
                ),
                InkWell(
                  onTap: () {
                    //TODO PAYMENT METHODE
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.credit_card,
                        size: 26,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
