import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal3by/authentication_screens/login_screen.dart';
import 'package:mal3by/authentication_screens/user_registration.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/routes/routs.dart';
import 'package:unicons/unicons.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NewCubit.get(context);
    return Scaffold(
      body: Stack(alignment: Alignment.topLeft, children: [
        const SizedBox(
          height: double.infinity,
          child: Image(
            image: AssetImage('images/newbk.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome To',
                        style: GoogleFonts.montserrat(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 50.0, end: 200),
                            duration: const Duration(seconds: 200),
                            builder: (_, value, child) {
                              return Transform.rotate(
                                angle: -3.14 / 2 * value,
                                child: const Icon(
                                  UniconsLine.football,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              );
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Text(
                            'Mal3by',
                            style: GoogleFonts.montserrat(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: choosebutton(context, 'Sign In', () {
                          Get.toNamed(RoutesClass.loginscreen);
                        }),
                      ),
                      Expanded(
                        child: choosebutton(context, 'Sign Up', () {
                          Get.toNamed(RoutesClass.registerscreen);
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget choosebutton(context, String title, Function() fun) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: MaterialButton(
          height: 40,
          color: appcolor,
          elevation: 15.0,
          colorBrightness: Brightness.light,
          onPressed: fun,
          child: Text(title,
              style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.white,
              ))),
    );
  }
}
