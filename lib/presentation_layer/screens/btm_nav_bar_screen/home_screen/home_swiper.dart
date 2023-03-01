import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_strings_manager/app_assets.dart';

class HomeSwiper extends StatelessWidget {
  const HomeSwiper({Key? key}) : super(key: key);

  static List<String>? offerImages = [
    AppAssets.swiperCardOne,
    AppAssets.swiperCardTwo,
    AppAssets.swiperCardThree,
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.28,
      child: Swiper(
        autoplay: false,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            offerImages![index],
            fit: BoxFit.fill,
          );
        },
        itemCount: offerImages!.length,
        pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
              color: Colors.white, activeColor: Colors.red),
        ),
        // control: SwiperControl(color: Colors.black),
      ),
    );
  }
}
