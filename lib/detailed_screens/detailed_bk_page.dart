import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';

class DetailedBgScreen extends StatefulWidget {
  const DetailedBgScreen({super.key});

  @override
  State<DetailedBgScreen> createState() => _DetailedBgScreenState();
}

class _DetailedBgScreenState extends State<DetailedBgScreen> {
  @override
  Widget build(BuildContext context) {
    var filterdatecontroller1 = TextEditingController();
    String filterpickeddate1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return BlocBuilder<NewCubit, AppStates>(builder: (context, state) {
      var cubit = NewCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(mymodel!.name.toString()),
          centerTitle: true,
          backgroundColor: appcolor,
        ),
        body: ConditionalBuilder(
            condition: state is! GetOrderErrorState,
            fallback: (context) => fallbackwidget(),
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/bk.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.sports_baseball_outlined,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                mymodel!.name.toString(),
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.black26,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.person_2_outlined,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                mymodel!.owner.toString(),
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black45),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.black26,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.map_outlined,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                mymodel!.address.toString(),
                                maxLines: 3,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black45),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.black26,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone_enabled_outlined,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                mymodel!.phone.toString(),
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black45),
                              ),
                            ],
                          ),
                          Divider(color: Colors.black),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: TextField(
                              readOnly: true,
                              controller: filterdatecontroller1,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2030));

                                if (pickedDate == null) {
                                  return;
                                } else {
                                  filterdatecontroller1.text =
                                      DateFormat('yyyy-MM-dd EEEE')
                                          .format(pickedDate);
                                  filterpickeddate1 = DateFormat('yyyy-MM-dd')
                                      .format(pickedDate);
                                }
                                cubit.getPendingOrders(
                                    DateFormat('yyyy-MM-dd').format(pickedDate),
                                    mymodel!.pId.toString(),
                                    context);
                              },
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: appcolor,
                                  constraints:
                                      const BoxConstraints(maxHeight: 40),
                                  contentPadding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  hintText: DateFormat('yyyy-MM-dd EEEE')
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
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(width: 2)),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: bookitem(
                                cubit.orders[index],
                                index,
                                false,
                                context,
                                mymodel!.pId.toString(),
                                mymodel!.name.toString()),
                          );
                        },
                        itemCount: cubit.orders.length,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              );
            }),
      );
    });
  }
}
