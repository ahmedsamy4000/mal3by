import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:mal3by/detailed_screens/detailed_bk_page_copy.dart';
import 'package:mal3by/main_screens/pending_orders_screen.dart';

class PlayGrounProfile extends StatelessWidget {
  const PlayGrounProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var filterdatecontroller = TextEditingController();
    var cubit = NewCubit.get(context);
    String filterbickeddate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    cubit.getProfilePendingOrders(
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        profilemodel!.userId.toString());
    cubit.getdetails(profilemodel!.userId.toString());
    return BlocConsumer<NewCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: cubit.pmodel != null,
            fallback: (context) {
              return fallbackwidget();
            },
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Profile'),
                  backgroundColor: appcolor,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0))),
                        child: const Image(
                          image: AssetImage('images/bk.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.margin_sharp),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    cubit.pmodel!.name.toString(),
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    cubit.pmodel!.owner.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: appcolor),
                                    child: TextButton(
                                      child: const Text(
                                        'Pending Orders',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        cubit.getProfilePendingOrders(
                                            DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now()),
                                            profilemodel!.userId.toString());
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PendingOrdersScreen()));
                                      },
                                    ),
                                  )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: appcolor),
                                    child: TextButton(
                                      child: const Text(
                                        'More Details',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DetailedBgScreen2()));
                                      },
                                    ),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'DashBoard',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      readOnly: true,
                                      controller: filterdatecontroller,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: cubit.pickedDate1,
                                                firstDate: DateTime(2023),
                                                lastDate: DateTime(2030));

                                        if (pickedDate == null) {
                                          pickedDate = cubit.pickedDate1;
                                        } else {
                                          filterdatecontroller.text =
                                              DateFormat('yyyy-MM-dd EEEE')
                                                  .format(pickedDate);
                                          filterbickeddate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          cubit.pickedDate1 = pickedDate;
                                        }
                                        cubit.getProfilePendingOrders(
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate),
                                          profilemodel!.userId.toString(),
                                        );
                                      },
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: appcolor,
                                          constraints: const BoxConstraints(
                                              maxHeight: 40),
                                          contentPadding: const EdgeInsets.only(
                                              top: 10, left: 10),
                                          hintText:
                                              DateFormat('yyyy-MM-dd EEEE')
                                                  .format(DateTime.now())
                                                  .toString(),
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                12.0,
                                              ),
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey))),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ConditionalBuilder(
                                condition: state
                                        is! GetProfilePendingOrderErrorState &&
                                    state is! GetOrderLoadingState,
                                fallback: (context) => fallbackwidget(),
                                builder: (context) {
                                  return Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(13),
                                        border: Border.all(width: 2)),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 4,
                                              crossAxisSpacing: 4),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: profilebookitem(
                                              cubit.orders[index],
                                              index,
                                              true,
                                              context,
                                              profilemodel!.userId.toString()),
                                        );
                                      },
                                      itemCount: cubit.orders.length,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
