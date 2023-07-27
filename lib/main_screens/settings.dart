import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var namecontroller = TextEditingController();
    var phonecontroller = TextEditingController();
    var addresscontroller = TextEditingController();

    return BlocConsumer<NewCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewCubit.get(context);
        namecontroller.text = profilemodel!.name.toString();
        phonecontroller.text = profilemodel!.phone.toString();
        addresscontroller.text = profilemodel!.address.toString();
        return ConditionalBuilder(
            condition: state is! NewUpdateLoadingState &&
                state is! ProfileUpdateLoadingState,
            fallback: (context) => Center(
                  child: SpinKitThreeBounce(
                    color: appcolor,
                    size: 18,
                  ),
                ),
            builder: (context) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 200,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  child: const Image(
                                    image: AssetImage('images/bk.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: cubit
                                                      .profileImage2 ==
                                                  null
                                              ? NetworkImage(profilemodel!.image
                                                  .toString())
                                              : FileImage(cubit.profileImage2!)
                                                  as ImageProvider),
                                    ),
                                  ),
                                  if (cubit.istyping)
                                    CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 20,
                                        child: Center(
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              cubit.updateImage();
                                            },
                                          ),
                                        )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            profilemodel!.name.toString(),
                            style: const TextStyle(
                                fontSize: 27, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextField(
                          controller: namecontroller,
                          keyboardType: TextInputType.text,
                          readOnly: !cubit.istyping,
                          decoration: InputDecoration(
                              hintText: 'your Name',
                              hintStyle: const TextStyle(fontSize: 13),
                              contentPadding: const EdgeInsets.all(6),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13.0))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: addresscontroller,
                          keyboardType: TextInputType.text,
                          readOnly: !cubit.istyping,
                          decoration: InputDecoration(
                              hintText: 'your Address',
                              hintStyle: const TextStyle(fontSize: 13),
                              contentPadding: const EdgeInsets.all(6),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13.0))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: phonecontroller,
                          readOnly: !cubit.istyping,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'your Phone',
                              hintStyle: const TextStyle(fontSize: 13),
                              contentPadding: const EdgeInsets.all(6),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13.0))),
                        ),
                        space(20),
                        FloatingActionButton(
                          onPressed: () {
                            if (cubit.istyping) {
                              if (cubit.profileImage2 == null) {
                                cubit.updateprofile(
                                    name: namecontroller.text,
                                    phone: phonecontroller.text,
                                    address: addresscontroller.text,
                                    image: profilemodel!.image.toString());
                                print('yess');
                              } else {
                                cubit.updateprofileImage(
                                  name: namecontroller.text,
                                  phone: phonecontroller.text,
                                  address: addresscontroller.text,
                                );
                                print('yess1');
                              }
                            } else {
                              cubit.changetype();
                            }
                          },
                          backgroundColor: appcolor,
                          elevation: 5.0,
                          child: Icon(cubit.icon),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
