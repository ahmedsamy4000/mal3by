import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';

class PlayGroundCheck extends StatefulWidget {
  const PlayGroundCheck({super.key});

  @override
  State<PlayGroundCheck> createState() => _PlayGroundCheckState();
}

class _PlayGroundCheckState extends State<PlayGroundCheck> {
  File? playgroundimage;
  Future<void> pickplayimage() async {
    XFile? pickedfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedfile != null) {
      setState(() {
        playgroundimage = File(pickedfile.path);
      });
    }
  }

  void removepick() {
    setState(() {
      playgroundimage = null;
    });
  }

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    var fullnamecontroller = TextEditingController();
    var addresscontroller = TextEditingController();
    var phonecontroller = TextEditingController();
    var locationcontroller = TextEditingController();
    var ownercontroller = TextEditingController();
    var ownerphonecontroller = TextEditingController();
    var mykey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('My PlayGround'),
        backgroundColor: appcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: mykey,
          child: Column(children: [
            Text(
              'Create your PlayGround',
              style: GoogleFonts.quicksand(
                  color: appcolor, fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Expanded(flex: 2, child: pickImagewidget()),
            space(10),
            infoTextField('Full Name', TextInputType.name, fullnamecontroller,
                Icons.sports_bar),
            infoTextField('Detailed Address', TextInputType.text,
                addresscontroller, Icons.info),
            infoTextField('Phone Number', TextInputType.phone, phonecontroller,
                Icons.phone),
            infoTextField('Location', TextInputType.text, locationcontroller,
                Icons.location_city_rounded),
            dropdownregion(),
            space(10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Personal info:',
                style: TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            infoTextField('Onwer Name', TextInputType.name, ownercontroller,
                Icons.person),
            infoTextField('Owner Phone', TextInputType.phone,
                ownerphonecontroller, Icons.phone),
            BlocListener<NewCubit, AppStates>(
                listener: (context, state) {
                  if (state is AddPlayGroundsSuccessState) {
                    setState(() {
                      isloading = false;
                    });
                  }
                },
                child: isloading == false
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: appcolor,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            child: Text(
                              'Confirm !!',
                              style: GoogleFonts.quicksand(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            onPressed: () {
                              if (mykey.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                if (playgroundimage != null) {
                                  firebase_storage.FirebaseStorage.instance
                                      .ref()
                                      .child(
                                          'posts/${Uri.file(playgroundimage!.path).pathSegments.last}')
                                      .putFile(playgroundimage!)
                                      .then((value) {
                                    NewCubit.get(context).addPlayGround(
                                        pId: profilemodel!.userId.toString(),
                                        userid: profilemodel!.userId.toString(),
                                        name: fullnamecontroller.text,
                                        owner: ownercontroller.text,
                                        region: currentregion,
                                        image: value.toString(),
                                        phone: phonecontroller.text,
                                        ownerphone: ownerphonecontroller.text,
                                        address: addresscontroller.text,
                                        location: locationcontroller.text);
                                  });
                                } else {
                                  NewCubit.get(context).addPlayGround(
                                      pId: profilemodel!.userId.toString(),
                                      userid: profilemodel!.userId.toString(),
                                      name: fullnamecontroller.text,
                                      owner: ownercontroller.text,
                                      region: currentregion,
                                      image: '',
                                      phone: phonecontroller.text,
                                      ownerphone: ownerphonecontroller.text,
                                      address: addresscontroller.text,
                                      location: locationcontroller.text);
                                }
                              }
                            },
                          ),
                        ),
                      )
                    : fallbackwidget()),
          ]),
        ),
      ),
    );
  }

  Widget pickImagewidget() {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: appcolor, borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: playgroundimage == null
            ? InkWell(
                onTap: () {
                  pickplayimage();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    Text(
                      'Click here to Pick Image',
                      style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image(
                      image: FileImage(playgroundimage!),
                      fit: BoxFit.fill,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        removepick();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ))
                ],
              ));
  }

  Widget dropdownregion() {
    return Expanded(
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Region:',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: appcolor, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButton(
                  underline: const SizedBox(),
                  alignment: Alignment.center,
                  items: regions.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  dropdownColor: appcolor,
                  iconEnabledColor: Colors.white,
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  elevation: 3,
                  isExpanded: true,
                  value: currentregion,
                  onChanged: (value) {
                    setState(() {
                      currentregion = value!;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoTextField(
      String hint, TextInputType type, var controller, IconData icon) {
    return Expanded(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'please fill this field';
          } else {
            return null;
          }
        },
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hint,
            hintStyle: TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold, color: appcolor),
            contentPadding: const EdgeInsets.all(6),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(13.0))),
      ),
    );
  }
}
