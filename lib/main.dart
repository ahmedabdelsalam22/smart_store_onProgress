import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/route_manager/app_routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  checkUserAuth();

  runApp(const MyApp());
}

String? initialRoute;
void checkUserAuth() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      initialRoute = AppRoutes.loginScreenRoute;
    } else {
      initialRoute = AppRoutes.btmNavScreenRoute;
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Store',
      initialRoute: AppRoutes.loginScreenRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
