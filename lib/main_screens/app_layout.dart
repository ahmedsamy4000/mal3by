import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:mal3by/main_screens/app_drawer.dart';
import 'package:mal3by/main_screens/search_screen.dart';
import 'package:mal3by/models/user_model.dart';

class AppLayOut extends StatelessWidget {
  const AppLayOut({super.key});

  @override
  Widget build(BuildContext context) {
    NewCubit.get(context).getuserdata();
    var cubit = NewCubit.get(context);
    return BlocConsumer<NewCubit, AppStates>(
        listener: ((context, state) {}),
        builder: ((context, state) {
          return ConditionalBuilder(
              condition: state is! GetUserDataLoadingState,
              fallback: (context) {
                return fallbackwidget();
              },
              builder: (context) {
                return Scaffold(
                  extendBody: true,
                  appBar: AppBar(
                    backgroundColor: appcolor,
                    centerTitle: true,
                    title: Text(
                      profilemodel!.name.toString(),
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(UniconsLine.search),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SearchScreen()));
                        },
                      )
                    ],
                  ),
                  drawer: const AppDrawer(),
                  body: cubit.screens[cubit.currentIndex],
                  bottomNavigationBar: DotNavigationBar(
                      duration: const Duration(milliseconds: 1200),
                      dotIndicatorColor: Colors.white,
                      unselectedItemColor: Colors.white,
                      currentIndex: cubit.currentIndex,
                      backgroundColor: appcolor,
                      onTap: (index) {
                        cubit.changeBottomNav(index);
                      },
                      items: [
                        DotNavigationBarItem(
                          icon: const Icon(UniconsLine.home_alt),
                          selectedColor: Colors.white,
                        ),

                        /// Likes
                        DotNavigationBarItem(
                          icon: const Icon(UniconsLine.list_ul),
                          selectedColor: Colors.white,
                        ),

                        /// Search
                        DotNavigationBarItem(
                          icon: const Icon(UniconsLine.location_pin_alt),
                          selectedColor: Colors.white,
                        ),

                        /// Profile
                        DotNavigationBarItem(
                          icon: const Icon(UniconsLine.setting),
                          selectedColor: Colors.white,
                        ),
                        // Icon(Icons.home),
                        // Icon(Icons.ballot_outlined),
                        // Icon(Icons.location_on),
                        // Icon(Icons.settings),
                      ]),
                );
              });
        }));
  }
}
