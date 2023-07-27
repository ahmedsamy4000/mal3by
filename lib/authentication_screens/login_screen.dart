import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/main_screens/app_layout.dart';
import 'package:unicons/unicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double blure = 0;
  IconData suffix = Icons.visibility_off_outlined;
  bool ispassword = true;
  var emailcontroller = TextEditingController();
  var pascontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        appbackground(),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blure, sigmaY: blure),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      ),
                      Text(
                        'login',
                        style: GoogleFonts.lobster(
                            color: Colors.white, fontSize: 50),
                      ),
                    ],
                  ),
                  space(20),
                  appLoginField('Email', emailcontroller, Icons.person, () {
                    setState(() {
                      blure = 10;
                    });
                  }),
                  space(20),
                  apppasswordLoginTextField2(
                    'Password',
                    pascontroller,
                    Icons.lock,
                    () {
                      setState(() {
                        blure = 10;
                      });
                    },
                    sicon: suffix,
                  ),
                  space(20),
                  BlocListener<NewCubit, AppStates>(
                    listener: (context, state) {
                      if (state is AppLoginLoadingState) {
                        showloadingdialog(context);
                      }
                      if (state is AppLoginSuccessState) {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AppLayOut()));
                      }
                      if (state is APPLoginErrorState) {
                        Navigator.pop(context);
                        showmydialog(
                            context,
                            const Text('Invalid email or Password'),
                            Iconsax.warning_2);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: appcolor),
                        child: TextButton(
                            onPressed: () {
                              NewCubit.get(context).userLogin(
                                  email: emailcontroller.text,
                                  password: pascontroller.text);
                            },
                            child: const Text(
                              'login',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      ),
                    ),
                  ),
                  space(10),
                  signupbutton(context),
                ]),
          ),
        ),
      ]),
    );
  }

  Widget apppasswordLoginTextField2(
      String hintTitle, var controller, IconData icon, void Function() fun,
      {IconData? sicon}) {
    return TextField(
      controller: controller,
      onTap: fun,
      obscureText: ispassword,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
              icon: Icon(sicon),
              onPressed: () {
                setState(() {
                  ispassword = !ispassword;
                  suffix = ispassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined;
                });
              }),
          filled: true,
          fillColor: Colors.white,
          hintText: hintTitle,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
    );
  }

  Widget appLoginField(String hintTitle, TextEditingController controller,
      IconData icon, void Function() fun) {
    return TextField(
      onTap: fun,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          hintText: hintTitle,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
