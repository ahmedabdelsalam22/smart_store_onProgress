import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_store/data_layer/data_source/firestore_remote_data_source.dart';
import 'package:smart_store/domain_layer/repository/firestore_repository.dart';
import 'package:smart_store/presentation_layer/controller/auth_cubit/auth_cubit.dart';
import 'package:smart_store/presentation_layer/controller/firestore_cubit/firestore_cubit.dart';

import 'core/route_manager/app_routes.dart';
import 'data_layer/data_source/auth_remote_data_source.dart';
import 'domain_layer/repository/auth_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
              AuthRepositoryImpl(AuthRemoteDataSourceImpl()),
              FireStoreRepositoryImpl(FireStoreRemoteDataSourceImpl())),
        ),
        BlocProvider(
            create: (context) => FireStoreCubit(
                FireStoreRepositoryImpl(FireStoreRemoteDataSourceImpl()))
              ..getAllProducts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lab Store',
        initialRoute: initialRoute,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
