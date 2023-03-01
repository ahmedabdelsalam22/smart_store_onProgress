import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/style/color_manager.dart';
import '../../../../data_layer/models/product_model.dart';
import '../../../widgets/main_button.dart';
import 'drop_down_menu.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailsScreen({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          productModel.title,
          style: Theme.of(context)
              .textTheme
              .headline4!
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            productModel.imageUrl,
            height: size.height * 0.5,
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
                InkWell(
                  onTap: () {
                    // TODO ADD TO FAVORITES
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        IconlyLight.heart,
                        size: 30,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.productCategoryName,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primary),
                    ),
                    Text(
                      productModel.title,
                      style: Theme.of(context).textTheme.caption!.copyWith(),
                    ),
                  ],
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
          ratingBar(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: MainButton(
              text: 'button',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  ratingBar() {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            RatingBar.builder(
              itemSize: 25,
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            const Text('5'),
          ],
        ),
      ),
    );
  }
}
