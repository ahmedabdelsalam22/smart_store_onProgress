import 'package:flutter/material.dart';

import 'build_categ_item.dart';

class TabBarViewBody extends StatelessWidget {
  final String categoryName;

  const TabBarViewBody({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return BuildCatItem();
        },
        itemCount: 4,
      ),
    );
  }
}
