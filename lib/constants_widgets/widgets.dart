import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mal3by/authentication_screens/user_registration.dart';
import 'package:mal3by/constants_widgets/constants.dart';

showmydialog(context, Widget content, IconData icon) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 2,
                ),
                content,
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('ok'))
            ],
          ));
}

showloadingdialog(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const SpinKitSpinningLines(
            color: Colors.white,
            size: 35,
          ));
}

Widget appbackground() {
  return const SizedBox(
    height: double.infinity,
    child: Image(
      image: AssetImage('images/newbk.png'),
      fit: BoxFit.fitHeight,
    ),
  );
}

Widget signupbutton(context) {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Expanded(
            child: Container(
          height: 1,
          color: Colors.black,
        )),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterScreen()));
            },
            child: const Text(
              'Sign Up ?',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        Expanded(
            child: Container(
          height: 1,
          color: Colors.black,
        )),
      ],
    ),
  );
}

Widget fallbackwidget() {
  return Center(
    child: Container(
      color: Colors.white,
      child: SpinKitSpinningLines(
        duration: const Duration(seconds: 2),
        color: appcolor,
        size: 30,
      ),
    ),
  );
}

Widget noItem(String content) {
  return Center(
    child: Text(
      content,
      style: TextStyle(color: Colors.grey[700]),
    ),
  );
}

Widget space(double h) {
  return SizedBox(
    height: h,
  );
}
