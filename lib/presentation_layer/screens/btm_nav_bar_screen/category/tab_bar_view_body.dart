import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/firestore_cubit/firestore_cubit.dart';
import '../../../controller/firestore_cubit/firestore_state.dart';
import 'build_categ_item.dart';

class TabBarViewBody extends StatelessWidget {
  final String categoryName;

  const TabBarViewBody({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FireStoreCubit, FireStoreState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = FireStoreCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return BuildCatItem(
                productModel: cubit.findByCategory(categoryName)[index],
              );
            },
            itemCount: cubit.findByCategory(categoryName).length,
          ),
        );
      },
    );
  }
}
