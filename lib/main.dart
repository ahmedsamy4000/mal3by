import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mal3by/authentication_screens/choose_screen.dart';
import 'package:mal3by/authentication_screens/login_screen.dart';
import 'package:mal3by/authentication_screens/user_registration.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mal3by/main_screens/activities.dart';
import 'package:mal3by/main_screens/app_layout.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mal3by/routes/routs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewCubit(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesClass.getHomeRoute(),
          getPages: RoutesClass.routes,
        ));
  }
}
