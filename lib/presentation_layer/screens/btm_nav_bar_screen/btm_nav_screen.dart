import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:smart_store/data_layer/models/cart_model.dart';
import 'package:smart_store/presentation_layer/controller/cart_cubit/cart_cubit.dart';
import 'package:smart_store/presentation_layer/screens/btm_nav_bar_screen/setting_screen/setting_screen.dart';

import '../../../core/style/color_manager.dart';
import '../../controller/cart_cubit/cart_state.dart';
import 'cart_screen/cart_screen.dart';
import 'category/category_screen.dart';
import 'fav_screen/favorites_screen.dart';
import 'home_screen/home_screen.dart';

class BtmNavScreen extends StatefulWidget {
  BtmNavScreen({Key? key}) : super(key: key);

  @override
  State<BtmNavScreen> createState() => _BtmNavScreenState();
}

class _BtmNavScreenState extends State<BtmNavScreen> {
  final _controller = PersistentTabController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);
    final cartList = cubit.getCartItems.values.toList().reversed.toList();

    return Scaffold(
      backgroundColor: ColorManager.backGround,
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = CartCubit.get(context);
          final cartList = cubit.getCartItems.values.toList().reversed.toList();

          return PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens,
            items: _navBarsItems(cartList),
            confineInSafeArea: true,
            backgroundColor: Colors.white,
            // Default is Colors.white.
            handleAndroidBackButtonPress: true,
            // Default is true.
            resizeToAvoidBottomInset: true,
            // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true,
            // Default is true.
            hideNavigationBarWhenKeyboardShows: true,
            // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style1, // Choose the nav bar style with this property.
          );
        },
      ),
    );
  }

  List<Widget> _buildScreens = [
    const HomeScreen(),
    CategoriesScreen(),
    const CartScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems(List<CartModel> cartList) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyLight.home),
        title: "Home",
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyLight.category),
        title: "Category",
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Badge(
          toAnimate: true,
          shape: BadgeShape.circle,
          badgeColor: Colors.red,
          borderRadius: BorderRadius.circular(8),
          position: BadgePosition.topEnd(top: -7, end: -7),
          badgeContent: Text('${cartList.length}'),
          child: Icon(IconlyLight.buy),
        ),
        title: "Cart",
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Badge(
          toAnimate: true,
          shape: BadgeShape.circle,
          badgeColor: Colors.red,
          borderRadius: BorderRadius.circular(8),
          position: BadgePosition.topEnd(top: -7, end: -7),
          badgeContent: Text('1'),
          child: Icon(IconlyLight.heart),
        ),
        title: "Favorites",
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyLight.setting),
        title: "Setting",
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
