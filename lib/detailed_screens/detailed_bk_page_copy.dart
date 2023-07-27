import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';

class DetailedBgScreen2 extends StatelessWidget {
  const DetailedBgScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NewCubit.get(context);
    return BlocConsumer<NewCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! DetailedPlayGroundLoadingState,
          fallback: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(cubit.pmodel!.name.toString()),
                centerTitle: true,
                backgroundColor: appcolor,
              ),
              body: SingleChildScrollView(
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
                                  'Name : ${cubit.pmodel!.name}',
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
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
                                  cubit.pmodel!.owner.toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black45),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
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
                                  cubit.pmodel!.address.toString(),
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black45),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.black26,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Location On Map',
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black45),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
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
                                  cubit.pmodel!.phone.toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black45),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.black26,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.alarm,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Work Time: 24h',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black45),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.black26,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.price_change_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Price: 150P',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black45),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            );
          },
        );
      },
    );
  }
}
