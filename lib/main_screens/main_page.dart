import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:mal3by/detailed_screens/detailed_bk_page.dart';
import 'package:mal3by/models/playgroundmodel.dart';
import 'package:mal3by/routes/routs.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    NewCubit.get(context).getplaygrounds();
    NewCubit.get(context).getfilteredplaygrounds(profilemodel!.region!);
    return BlocConsumer<NewCubit, AppStates>(
        listener: (context, state) {},
        builder: ((context, state) {
          var cubit = NewCubit.get(context);
          return ConditionalBuilder(
              condition: state is! GetPlayGroundsLoadingState &&
                  state is! GetPlayFilteredGroundsLoadingState,
              fallback: (context) {
                return fallbackwidget();
              },
              builder: (context) {
                return Scaffold(
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(profilemodel!.region.toString(),
                                  style: GoogleFonts.quicksand(
                                      color: appcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              const SizedBox(
                                width: 15,
                              ),
                              const Icon(Icons.home)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Colors.grey[300]),
                            width: double.infinity,
                            height: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text('Recommended',
                                        style: GoogleFonts.quicksand(
                                            color: appcolor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25)),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: ConditionalBuilder(
                                        condition: state
                                            is! GetPlayFilteredGroundsLoadingState,
                                        fallback: (context) => fallbackwidget(),
                                        builder: (context) {
                                          return cubit
                                                  .filteredPlayGrounds.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    'No Recommended Items yet!',
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            color: appcolor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                  ),
                                                )
                                              : ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const BouncingScrollPhysics(
                                                          parent:
                                                              AlwaysScrollableScrollPhysics()),
                                                  itemBuilder: (context,
                                                          index) =>
                                                      recommendedItem(
                                                          cubit.filteredPlayGrounds[
                                                              index],
                                                          context),
                                                  itemCount: cubit
                                                      .filteredPlayGrounds
                                                      .length,
                                                );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              mainItem(cubit.playgrounds[index], context),
                          itemCount: cubit.playgrounds.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }));
  }
}

Widget mainItem(PlayModel model, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: GestureDetector(
      onTap: () {
        mymodel = model;
        NewCubit.get(context).getPendingOrders(
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
            model.pId.toString(),
            context);
        print(mymodel!.pId);
      },
      child: Card(
        elevation: 5.0,
        shadowColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          13.0,
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      image: AssetImage('images/bk.jpg'), fit: BoxFit.cover),
                ),
              ),
              space(10),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 20,
                    color: appcolor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(model.name.toString(),
                      style: GoogleFonts.quicksand(
                          color: Colors.black87, fontWeight: FontWeight.bold)),
                ],
              ),
              space(10),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 20,
                    color: appcolor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(model.address.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.quicksand(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: appcolor,
                          borderRadius: BorderRadius.circular(13.0)),
                      child: const Text(
                        '\$ 150',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget recommendedItem(PlayModel model, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: GestureDetector(
      onTap: () {
        mymodel = model;
        NewCubit.get(context).getPendingOrders(
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
            model.pId.toString(),
            context);
        print(mymodel!.pId);
      },
      child: Card(
        elevation: 5.0,
        shadowColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          13.0,
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage('images/bk.jpg'), fit: BoxFit.cover),
                  ),
                ),
                space(10),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 20,
                      color: appcolor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(model.name.toString(),
                        style: GoogleFonts.quicksand(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                space(10),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: appcolor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(model.address.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.quicksand(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
