import 'package:get/get.dart';
import 'package:mal3by/authentication_screens/choose_screen.dart';
import 'package:mal3by/authentication_screens/login_screen.dart';
import 'package:mal3by/authentication_screens/user_registration.dart';
import 'package:mal3by/detailed_screens/booking_screen.dart';

import 'package:mal3by/detailed_screens/detailed_bk_page.dart';
import 'package:mal3by/detailed_screens/detailed_bk_page_copy.dart';
import 'package:mal3by/detailed_screens/detailed_regions.dart';
import 'package:mal3by/detailed_screens/play_ground_profile.dart';
import 'package:mal3by/detailed_screens/playground_check.dart';
import 'package:mal3by/main_screens/pending_orders_screen.dart';
import 'package:mal3by/main_screens/search_screen.dart';

class RoutesClass {
  static String home = '/';
  static String loginscreen = '/loginscreen';
  static String registerscreen = '/registerscreen';
  static String detailedscreen = '/detailedscreen';
  static String createprofilescreen = '/createprofilescreen';
  static String pendingordersscreen = '/pendingordersscreen';
  static String searchscreen = '/searchscreen';
  static String bookingscreen = '/bookingscreen';
  static String detailedscreencopy = '/detailedscreencopy';
  static String detailedregion = '/detailedregion';
  static String detailedregions = '/detailedregions';
  static String playgroundprofile = '/playgroundprofile';
  static String playgroundcheck = '/playgroundcheck';

  static String getHomeRoute() => home;
  static String getloginscreenRoute() => loginscreen;
  static String getRegisterscreenRoute() => registerscreen;
  static String getdetailedscreenRoute() => detailedscreen;
  static String createprofilescreenRoute() => createprofilescreen;
  static String pendingordersscreenRoute() => pendingordersscreen;
  static String searchscreenRoute() => searchscreen;
  static String bookingscreenRoute() => bookingscreen;
  static String detailedscreencopyRoute() => detailedscreencopy;
  static String detailedregionRoute() => detailedregion;
  static String detailedregionsRoute() => detailedregions;
  static String playgroundprofileRoute() => playgroundprofile;
  static String playgroundcheckRoute() => playgroundcheck;

  static List<GetPage> routes = [
    GetPage(maintainState: false, name: home, page: () => const ChooseScreen()),
    GetPage(
        maintainState: false,
        name: loginscreen,
        page: () => const LoginScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 600)),
    GetPage(
        maintainState: false,
        name: registerscreen,
        page: () => const RegisterScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 600)),
    GetPage(
      name: createprofilescreen,
      page: () => const DetailedBgScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: pendingordersscreen,
      page: () => const PendingOrdersScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: searchscreen,
      page: () => const SearchScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: bookingscreen,
      page: () => const BookingScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: detailedscreencopy,
      page: () => const DetailedBgScreen2(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: detailedregion,
      page: () => DetailedRegions(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: playgroundprofile,
      page: () => const PlayGrounProfile(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: playgroundcheck,
      page: () => const PlayGroundCheck(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 200),
    ),
  ];
}
