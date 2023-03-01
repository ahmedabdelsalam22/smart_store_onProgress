import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/route_manager/app_routes.dart';
import '../../../../core/style/color_manager.dart';

class productItemBuilder extends StatelessWidget {
  const productItemBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          AppRoutes.productDetailsScreenRoute,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                SizedBox(
                  width: 145,
                  height: 170,
                  child: Image(
                    image: AssetImage('assets/images/category/bag.jpg'),
                    fit: BoxFit.scaleDown,
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
                          IconlyBold.heart,
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
                          IconlyBold.buy,
                          size: 30,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            RatingBarIndicator(
              itemSize: 25.0,
              //   rating: dummyProduct.rate?.toDouble() ?? 4.0,
              rating: 4.1,
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
                'title',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              'CategoryName',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('90\$',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '75\$',
                  style: TextStyle(color: ColorManager.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

/* ratingBar(int? rate) {
    return SizedBox(
      child: Row(
        children: [
          RatingBar.builder(
            itemSize: 23,
            initialRating: rate!.toDouble(),
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
          Text('$rate'),
        ],
      ),
    );
  }*/

}
