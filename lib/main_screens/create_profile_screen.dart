import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/detailed_screens/playground_check.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appcolor,
        title: Text(
          'Create Profile',
          style: GoogleFonts.quicksand(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Center(
        child: MaterialButton(
            color: appcolor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PlayGroundCheck()));
            },
            child: Text(
              'Create your PlayGround',
              style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
      ),
    );
  }
}
