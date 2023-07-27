import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:mal3by/models/order_model.dart';

class PendingOrdersScreen extends StatelessWidget {
  const PendingOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NewCubit.get(context);
    return BlocConsumer<NewCubit, AppStates>(
        listener: (context, state) {},
        builder: ((context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appcolor,
              title: const Text('Pending Orders'),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) =>
                  pendingorderitem(cubit.pendingorders[index], context),
              itemCount: cubit.pendingorders.length,
            ),
          );
        }));
  }

  Widget pendingorderitem(OrderModel model, context) {
    var cubit = NewCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 100,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black),
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'images/loading.gif',
                    placeholderScale: 5,
                    imageScale: 1,
                    image: profilemodel!.image.toString()),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.ballot_outlined,
                            color: Colors.green,
                          ),
                          Expanded(
                            child: Text(
                              model.name.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.alarm,
                            color: Colors.green,
                          ),
                          Expanded(
                            child: Text(
                              model.orderdate.toString(),
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.stacked_line_chart_sharp,
                            color: Colors.green,
                          ),
                          Text(
                            model.time.toString(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.phone_enabled_outlined,
                            color: Colors.green,
                          ),
                          Text(
                            'Phone number',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  cubit.deletePendingOrder(
                      model.orderid.toString(), model.orderdate.toString());
                  cubit.getProfilePendingOrders(
                      DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      profilemodel!.userId.toString());
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 30,
                )),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  cubit.addOrder(
                      name: model.name.toString(),
                      pickedDate: DateTime.parse(model.orderdate.toString()),
                      booked: true,
                      image: '',
                      userid: profilemodel!.userId.toString(),
                      time: model.time.toString());
                  cubit.changestate(model.orderid.toString());
                  cubit.getProfilePendingOrders(
                      DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      profilemodel!.userId.toString());
                },
                icon: const Icon(
                  Icons.add_task,
                  color: Colors.green,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
