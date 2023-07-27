import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:mal3by/detailed_screens/detailed_bk_page.dart';
import 'package:mal3by/models/playgroundmodel.dart';
import 'package:mal3by/routes/routs.dart';

class DetailedRegions extends StatelessWidget {
  String? name;
  DetailedRegions({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    var cubit = NewCubit.get(context);
    cubit.getfilteredplaygrounds(name!);
    return BlocConsumer<NewCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appcolor,
              title: Row(children: [
                const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(name!)
              ]),
            ),
            body: ConditionalBuilder(
              condition: state is! GetPlayFilteredGroundsLoadingState,
              fallback: (context) => fallbackwidget(),
              builder: (context) => cubit.filteredPlayGrounds.isEmpty
                  ? noItem('No PlayGrounds Here!!')
                  : ListView.builder(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) =>
                          regionitem(context, cubit.filteredPlayGrounds[index]),
                      itemCount: cubit.filteredPlayGrounds.length,
                    ),
            ),
          );
        });
  }
}

Widget regionitem(context, PlayModel model) {
  mymodel = model;
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: GestureDetector(
      onTap: () {
        mymodel = model;
        NewCubit.get(context).getPendingOrders(
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
            model.pId.toString(),
            context);
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
                  Text(model.address.toString(),
                      style: GoogleFonts.quicksand(
                          color: Colors.black87, fontWeight: FontWeight.bold)),
                  const Spacer(),
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
