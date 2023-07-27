import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/detailed_screens/playground_check.dart';
import 'package:mal3by/main_screens/create_profile_screen.dart';
import 'package:mal3by/models/user_model.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool val1 = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: double.infinity,
          color: appcolor,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (profilemodel!.image != null)
              Expanded(
                flex: 1,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: FadeInImage.assetNetwork(
                          placeholder: 'images/loading.gif',
                          placeholderScale: 5,
                          imageScale: 1,
                          image: profilemodel!.image.toString()),
                    ),
                  ),
                ),
              ),
            Expanded(
              flex: 0,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(profilemodel!.name!,
                      style: GoogleFonts.fjallaOne(
                          color: Colors.white, fontSize: 30)),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Row(children: [
                          const Icon(Iconsax.activity),
                          const Text(
                            'Pending Player',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Switch(
                              value: val1,
                              onChanged: (value) {
                                setState(() {
                                  val1 = value;
                                });
                              }),
                        ]),
                      ),
                      space(5),
                      GestureDetector(
                        child: Row(children: const [
                          Icon(Iconsax.information),
                          Text(
                            'Online PlayGrounds',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text('13'),
                        ]),
                      ),
                      space(20),
                      GestureDetector(
                        child: Row(children: const [
                          Icon(Iconsax.language_circle),
                          Text(
                            'Language',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text('En'),
                        ]),
                      ),
                      space(20),
                      GestureDetector(
                        child: Row(children: const [
                          Icon(Icons.phone),
                          Text(
                            'Contact Us',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Icon(Icons.phone),
                        ]),
                      ),
                      space(20),
                      GestureDetector(
                        onTap: () {
                          NewCubit.get(context).chekPlaygroundexist(context);
                        },
                        child: Row(children: const [
                          Icon(Iconsax.edit),
                          Text(
                            'My PlayGround',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Icon(Icons.playlist_add_check_sharp),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    ));
  }
}
