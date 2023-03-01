import 'package:flutter/material.dart';

import '../../data_layer/models/product_model.dart';
import '../../presentation_layer/screens/auth/forget_password_screen.dart';
import '../../presentation_layer/screens/auth/login_screen.dart';
import '../../presentation_layer/screens/auth/register_screen.dart';
import '../../presentation_layer/screens/btm_nav_bar_screen/btm_nav_screen.dart';
import '../../presentation_layer/screens/btm_nav_bar_screen/details_screen/details_screen.dart';
import '../../presentation_layer/screens/btm_nav_bar_screen/view_all_product_screen/view_all_product_screen.dart';
import '../../presentation_layer/screens/btm_nav_bar_screen/view_on_sale_product_screen/view_on_sale_product_screen.dart';

class AppRoutes {
  static const String loginScreenRoute = 'loginScreen';
  static const String registerScreenRoute = 'registerScreen';
  static const String forgetPasswordScreenRoute = 'forgetPasswordScreen';
  static const String btmNavScreenRoute = 'btmNavScreen';
  static const String productDetailsScreenRoute = 'productDetailsScreen';
  static const String viewOnSaleProductsScreenRoute =
      'viewOnSaleProductsScreen';
  static const String viewAllProductsScreenRoute = 'viewAllProductsScreen';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.registerScreenRoute:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );

      case AppRoutes.loginScreenRoute:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);

      case AppRoutes.forgetPasswordScreenRoute:
        return MaterialPageRoute(
            builder: (_) => ForgetPasswordScreen(), settings: settings);

      case AppRoutes.btmNavScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BtmNavScreen(), settings: settings);

      case AppRoutes.productDetailsScreenRoute:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(productModel: product),
          settings: settings,
        );

      case AppRoutes.viewOnSaleProductsScreenRoute:
        return MaterialPageRoute(
          builder: (_) => ViewAllOnSaleProductsScreen(),
          settings: settings,
        );

      case AppRoutes.viewAllProductsScreenRoute:
        return MaterialPageRoute(
          builder: (_) => ViewAllProductScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
            builder: (_) => const LoginScreen(), settings: settings);
    }
  }
}
