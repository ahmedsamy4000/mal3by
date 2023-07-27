import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:mal3by/main_screens/app_layout.dart';
import 'package:unicons/unicons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  double blure = 0;
  IconData suffix = Icons.visibility_off_outlined;
  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(alignment: Alignment.center, children: [
          const SizedBox(
            height: double.infinity,
            child: Image(
              image: AssetImage('images/newbk.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          SingleChildScrollView(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blure, sigmaY: blure),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        UniconsLine.football,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text('Register',
                          style: GoogleFonts.lobster(
                              fontSize: 40, color: Colors.white)),
                      const SizedBox(width: 50),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: BlocBuilder<NewCubit, AppStates>(
                              builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image(
                                        fit: BoxFit.fill,
                                        image: NewCubit.get(context)
                                                    .profileimage ==
                                                null
                                            ? const AssetImage(
                                                    'images/pimage.jpg')
                                                as ImageProvider
                                            : FileImage(NewCubit.get(context)
                                                .profileimage!)),
                                  ),
                                );
                              },
                            ),
                          ),
                          CircleAvatar(
                              backgroundColor: appcolor,
                              radius: 14,
                              child: IconButton(
                                onPressed: () {
                                  NewCubit.get(context).getPostImage();
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: NewCubit.get(context).formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            space(10),
                            appregisterTextField1('UserName', nameController,
                                Icons.person, context, TextInputType.name, () {
                              setState(() {
                                blure = 10;
                              });
                            }),
                            space(10),
                            appregisterTextField1(
                                'Email',
                                emailController,
                                Icons.email,
                                context,
                                TextInputType.emailAddress, () {
                              setState(() {
                                blure = 10;
                              });
                            }),
                            space(10),
                            apppasswordTextField1('Password',
                                passwordController, Icons.lock, context,
                                sicon: suffix),
                            space(10),
                            appregisterTextField1('phone', phoneController,
                                Icons.phone, context, TextInputType.phone, () {
                              setState(() {
                                blure = 10;
                              });
                            }),
                            space(10),
                            appregisterTextField1(
                                'address',
                                addressController,
                                Icons.location_on,
                                context,
                                TextInputType.streetAddress, () {
                              setState(() {
                                blure = 10;
                              });
                            }),
                            space(20),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Choose Region',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: DropdownButton(
                                      underline: const SizedBox(),
                                      alignment: Alignment.center,
                                      items: regions.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      dropdownColor: Colors.green,
                                      iconEnabledColor: appcolor,
                                      value: currentregion,
                                      onChanged: (value) {
                                        setState(() {
                                          currentregion = value!;
                                        });
                                      },
                                      elevation: 1,
                                      isExpanded: true,
                                      menuMaxHeight: 500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            space(20),
                            BlocListener<NewCubit, AppStates>(
                              listener: (context, state) {
                                if (state is AppRegisterSuccessState &&
                                    state is! GetUserDataErrorState) {
                                  navigateto(context, const AppLayOut());
                                } else if (state is AppRegisterLoadingState ||
                                    state is UploadProfileImageLoadingState) {
                                  showloadingdialog(context);
                                }
                              },
                              child: Center(
                                child: MaterialButton(
                                    height: 50,
                                    elevation: 15.0,
                                    color: appcolor,
                                    onPressed: () {
                                      if (NewCubit.get(context)
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        if (NewCubit.get(context)
                                                .profileimage ==
                                            null) {
                                          NewCubit.get(context).userRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text,
                                            address: addressController.text,
                                            region: currentregion,
                                          );
                                        } else {
                                          NewCubit.get(context)
                                              .uploadprofileImage(
                                                  name: nameController.text,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  region: currentregion,
                                                  phone: phoneController.text,
                                                  address:
                                                      addressController.text);
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 80.0),
                                      child: Text('Register',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    )),
                              ),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget apppasswordTextField1(
      String hintTitle, var controller, IconData icon, context,
      {IconData? sicon}) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'please fill your password';
        } else {
          return null;
        }
      },
      controller: controller,
      obscureText: ispassword,
      decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.white),
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
}
