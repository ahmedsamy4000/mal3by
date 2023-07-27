import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:mal3by/cubit/try.dart';
import 'package:mal3by/detailed_screens/play_ground_profile.dart';
import 'package:mal3by/main_screens/activities.dart';
import 'package:mal3by/main_screens/create_profile_screen.dart';
import 'package:mal3by/main_screens/main_page.dart';
import 'package:mal3by/main_screens/regions.dart';
import 'package:mal3by/main_screens/settings.dart';
import 'package:mal3by/models/activity_model.dart';
import 'package:mal3by/models/order_model.dart';
import 'package:mal3by/models/playgroundmodel.dart';
import 'package:mal3by/models/user_model.dart';
import 'package:mal3by/routes/routs.dart';

class NewCubit extends Cubit<AppStates> {
  NewCubit() : super(AppInitialState());

  static NewCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<String> titles = ['Home', 'Activites', 'Regions', 'Settings'];
  double blure = 0;
  void changeblure() {
    blure = 10;
    emit(ChangeBlureState());
  }

  final formKey = GlobalKey<FormState>();

  bool isPasswordValid(String password) => password.length == 6;
  bool isEmailValid(String email) {
    Pattern pattern =
        '^(([^<>()[]\\.,;:s@"]+(.[^<>()[]\\.,;:s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  File? profileimage;

  void getPostImage() async {
    XFile? PickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (PickedFile != null) {
      profileimage = File(PickedFile.path);
      emit(PickProfileImageSuccessState());
    } else {
      emit(PickProfileImageErrorState());
    }
  }

  bool istyping = false;
  IconData icon = Icons.edit;
  void changetype() {
    istyping = !istyping;
    icon = istyping ? Icons.done : Icons.edit;
    emit(ProfileUpdateChangereadState());
  }

  File? profileImage2;
  void updateImage() async {
    XFile? PickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (PickedFile != null) {
      profileImage2 = File(PickedFile.path);
      emit(ProfilePickLoadingState());
    } else {
      emit(ProfilePickSuccessState());
    }
  }

  void updateprofile({
    required String name,
    required String phone,
    required String address,
    required String image,
  }) {
    emit(ProfileUpdateLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(profilemodel!.userId)
        .update({
      'name': name,
      'phone': phone,
      'address': address,
      'image': image
    }).then((value) {
      emit(ProfileUpdateSuccessState());
      changetype();
      getuserdata();
    }).catchError((error) {
      print(error);
    });
  }

  void updateprofileImage({
    required String name,
    required String phone,
    required String address,
  }) {
    emit(NewUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(profileImage2!.path).pathSegments.last}')
        .putFile(profileImage2!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateprofile(name: name, phone: phone, address: address, image: value);
      }).catchError((error) {
        emit(NewUpdateErrorState());
      });

      emit(NewUpdateSuccessState());

      getuserdata();
    }).catchError((error) {
      print(error);
    });
  }

  void uploadprofileImage(
      {required String name,
      required String email,
      required String password,
      required String region,
      required String address,
      required String phone}) {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userRegister(
            name: name,
            email: email,
            password: password,
            image: value,
            region: region,
            address: address,
            phone: phone);
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(APPRegisterErrorState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    });
  }

  var pickedcontroller = TextEditingController();
  var ordernamecontroller = TextEditingController();
  DateTime pickedDate1 = DateTime.now();
  String? selectVal;
  void showMyDialog(context, bool booked, String userid, String time,
      DateTime mydate, String playgroundname) {
    showAnimatedDialog(
      barrierDismissible: true,
      animationType: DialogTransitionType.fade,
      context: context,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.hardEdge,
          insetAnimationDuration: const Duration(milliseconds: 700),
          elevation: 10,
          backgroundColor: appcolor,
          child: Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: appcolor),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: ordernamecontroller,
                      decoration: InputDecoration(
                          hintText: 'Name',
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: const TextStyle(fontSize: 13),
                          contentPadding: const EdgeInsets.all(6),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13.0))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: MaterialButton(
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                    color: appcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: MaterialButton(
                              color: Colors.white,
                              onPressed: () {
                                addOrder(
                                    userid: userid,
                                    name: ordernamecontroller.text,
                                    booked: booked,
                                    image: profilemodel!.image.toString(),
                                    pickedDate: DateTime.parse(
                                        DateFormat('yyyy-MM-dd')
                                            .format(mydate)),
                                    time: time);
                                if (booked) {
                                  getProfilePendingOrders(
                                      DateFormat('yyyy-MM-dd').format(mydate),
                                      userid.toString());
                                }
                                getPendingOrders(
                                    DateFormat('yyyy-MM-dd').format(mydate),
                                    userid.toString(),
                                    context);
                                addActivity(
                                    userid: profilemodel!.userId!,
                                    name: ordernamecontroller.text,
                                    playgroundname: playgroundname,
                                    pickedDate: DateTime.parse(
                                        DateFormat('yyyy-MM-dd')
                                            .format(mydate)),
                                    time: time,
                                    booked: booked);
                                Navigator.pop(context);
                                ordernamecontroller.text = '';
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    color: appcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showMyprofileDialog(
    context,
    bool booked,
    String userid,
    String time,
    DateTime mydate,
  ) {
    showAnimatedDialog(
      animationType: DialogTransitionType.fade,
      context: context,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.hardEdge,
          insetAnimationDuration: const Duration(milliseconds: 700),
          elevation: 10,
          backgroundColor: appcolor,
          child: Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: appcolor),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: ordernamecontroller,
                      decoration: InputDecoration(
                          hintText: 'Name',
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: const TextStyle(fontSize: 13),
                          contentPadding: const EdgeInsets.all(6),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13.0))),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: MaterialButton(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                      color: appcolor,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: MaterialButton(
                                color: Colors.white,
                                onPressed: () {
                                  addOrder(
                                      userid: userid,
                                      name: ordernamecontroller.text,
                                      image: '',
                                      booked: booked,
                                      pickedDate: DateTime.parse(
                                          DateFormat('yyyy-MM-dd')
                                              .format(mydate)),
                                      time: time);
                                  if (booked) {
                                    getProfilePendingOrders(
                                        DateFormat('yyyy-MM-dd')
                                            .format(DateTime.now()),
                                        userid.toString());
                                  } else {
                                    getPendingOrders(
                                        DateFormat('yyyy-MM-dd')
                                            .format(DateTime.now()),
                                        userid.toString(),
                                        context);
                                  }
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      color: appcolor,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> screens = [
    const MainPage(),
    const ActivitiesScreen(),
    const RegionsScreen(),
    const SettingsScreen(),
  ];
  void changeBottomNav(
    int index,
  ) {
    currentIndex = index;
    emit(ChangeBotttomNavState());
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changeVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibility());
  }

  void userLogin({required String email, required String password}) {
    emit(AppLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      profilemodel!.userId = value.user!.uid;
      emit(AppLoginSuccessState());
    }).catchError((error) {
      emit(APPLoginErrorState());
    });
  }

  List<PlayModel> searchgrounds = [];

  void searchplaygrounds(String search) {
    searchgrounds = [];
    emit(SearchGroundLoadingState());
    if (search.isEmpty) {
      searchgrounds = [];
    } else {
      FirebaseFirestore.instance.collection('playgrounds').get().then((value) {
        value.docs.forEach((element) {
          if (element['name'].toString().contains(search)) {
            searchgrounds.add(PlayModel.fromJson(element.data()));
          }
        });
        emit(SearchGroundSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SearchGroundErrorState());
      });
    }
  }

  void getuserdata() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(profilemodel!.userId)
        .get()
        .then((value) {
      profilemodel = UserModel.fromJson(value.data()!);
      print(profilemodel!.region);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
    String? image,
    required String region,
  }) {
    emit(AppRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      addUser(
          name: name,
          email: email,
          userid: value.user!.uid.toString(),
          region: region,
          address: address,
          phone: phone,
          image: image ??
              'https://firebasestorage.googleapis.com/v0/b/mal3by-22904.appspot.com/o/posts%2Fpimage.jpg?alt=media&token=bb6d6e14-b2a7-4688-8801-188533a99844');
      profilemodel!.userId = value.user!.uid.toString();
      getuserdata();
      emit(AppRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(APPLoginErrorState());
    });
  }

  void addUser(
      {required String name,
      required String email,
      required String userid,
      required String image,
      required String address,
      required String phone,
      required String region}) {
    emit(AddUserLoadingState());
    UserModel model = UserModel(
        userId: userid,
        name: name,
        email: email,
        image: image,
        region: region,
        address: address,
        phone: phone);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .set(model.toMap())
        .then((value) {
      emit(AddUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddUserErrorState());
    });
  }

  var orders = [];
  var pendingorders = [];
  var activities = [];

  void deleteActivity(String id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(profilemodel!.userId)
        .collection('activities')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteActivitySuccessState());
    }).catchError((error) {
      print(error);
      emit(DeleteActivityErrorState());
    });
    getActivities();
  }

  void deletePendingOrder(String id, String date) {
    FirebaseFirestore.instance
        .collection('playgrounds')
        .doc(profilemodel!.userId)
        .collection('orders')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeletePendingOrderSuccessState());
    }).catchError((error) {
      print(error);
      emit(DeletePendingOrderErrorState());
    });
  }

  void getActivities() {
    activities = [];
    emit(GetActivityLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(profilemodel!.userId)
        .collection('activities')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        activities.add(ActivityModel.fromJson(element.data()));
      });
      emit(GetActivitySuccessState());
    }).catchError((error) {
      print(error);
      emit(GetActivityErrorState());
    });
  }

  void addActivity(
      {String? activityId,
      required String playgroundname,
      required String userid,
      required String name,
      required DateTime pickedDate,
      required String time,
      required bool booked}) {
    emit(AddActivityLoadingState());
    ActivityModel activityModel = ActivityModel(
        activityId: activityId,
        personalId: profilemodel!.userId,
        name: name,
        playgroundname: playgroundname,
        activityDate: DateFormat('yyyy-MM-dd').format(pickedDate),
        time: time,
        status: booked);
    FirebaseFirestore.instance
        .collection('users')
        .doc(profilemodel!.userId.toString())
        .collection('activities')
        .add(activityModel.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userid.toString())
          .collection('activities')
          .doc(value.id)
          .update({'activityId': value.id});
      emit(AddActivitySuccessState());
    }).catchError((error) {
      print(error);
      emit(AddActivityErrorState());
    });
  }

  void addOrder(
      {String? orderid,
      required String userid,
      required String name,
      required DateTime pickedDate,
      required String image,
      required String time,
      required bool booked}) {
    emit(AddOrderLoadingState());
    OrderModel ordermodel = OrderModel(
        orderid: orderid,
        name: name,
        orderdate: DateFormat('yyyy-MM-dd').format(pickedDate),
        time: time,
        image: image,
        booked: booked);
    FirebaseFirestore.instance
        .collection('playgrounds')
        .doc(userid.toString())
        .collection('orders')
        .add(ordermodel.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('playgrounds')
          .doc(userid.toString())
          .collection('orders')
          .doc(value.id)
          .update({'orderid': value.id});
      emit(AddOrderSuccessState());
    }).catchError((error) {
      print(error);
    });
  }

  void addPlayGround(
      {String? pId,
      required String userid,
      required String name,
      required String owner,
      required String region,
      required String phone,
      required String ownerphone,
      required String address,
      required String location,
      required String? image}) {
    emit(AddPlayGroundsLoadingState());
    PlayModel playmodel = PlayModel(
        pId: pId,
        name: name,
        owner: owner,
        region: region,
        address: address,
        location: location,
        image: image ?? '__',
        ownerphone: ownerphone);

    FirebaseFirestore.instance
        .collection('playgrounds')
        .doc(profilemodel!.userId)
        .set(playmodel.toMap())
        .then((value) {
      emit(AddPlayGroundsSuccessState());
    }).catchError((error) {
      print(error);
      emit(AddPlayGroundsErrorState());
    });
  }

  void changestate(String orderid) {
    FirebaseFirestore.instance
        .collection('playgrounds')
        .doc(profilemodel!.userId)
        .collection('orders')
        .doc(orderid)
        .update({'booked': true});
  }

  void getorders(String mydate) {
    orders = [];
    for (int i = 0; i < 12; i++) {
      orders.add(OrderModel(
          booked: false, time: (i + 1).toString(), orderdate: mydate));
    }
  }

  void getPendingOrders(String mydate, String id, context) {
    getorders(mydate);
    pendingorders = [];
    emit(GetOrderLoadingState());
    showloadingdialog(context);
    print('loadint');
    FirebaseFirestore.instance
        .collection('playgrounds')
        .doc(id)
        .collection('orders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['booked'] == true) {
          for (int i = 0; i < 12; i++) {
            if (element.data()['time'] == orders[i].time &&
                '${element.data()['orderdate']}' == orders[i].orderdate) {
              orders[i] = OrderModel.fromJson(element.data());
            }
          }
        } else {
          pendingorders.add(OrderModel.fromJson(element.data()));
        }
      });
      Navigator.pop(context);
      emit(GetOrderSuccessState());
      print('success');
      Get.toNamed(RoutesClass.detailedscreen);
    }).catchError((error) {
      print(error);
      emit(GetOrderErrorState());
      print('error');
    });
  }

  void getProfilePendingOrders(String mydate, String id) {
    getorders(mydate);
    pendingorders = [];
    emit(GetProfilePendingOrderLoadingState());
    print('loadint');
    FirebaseFirestore.instance
        .collection('playgrounds')
        .doc(id)
        .collection('orders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['booked'] == true) {
          for (int i = 0; i < 12; i++) {
            if (element.data()['time'] == orders[i].time &&
                '${element.data()['orderdate']}' == orders[i].orderdate) {
              orders[i] = OrderModel.fromJson(element.data());
            }
          }
        } else {
          pendingorders.add(OrderModel.fromJson(element.data()));
        }
      });
      emit(GetProfilePendingOrderSuccessState());
      print('success');
    }).catchError((error) {
      print(error);
      emit(GetOrderErrorState());
      print('error');
    });
  }

  PlayModel? pmodel;
  void getdetails(String id) {
    emit(GetProfilePendingOrderErrorState());
    FirebaseFirestore.instance
        .collection('playgrounds')
        .doc(id)
        .get()
        .then((value) {
      pmodel = PlayModel.fromJson(value.data()!);
      emit(DetailedPlayGroundSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DetailedPlayGroundErrorState());
    });
  }

  List<PlayModel> playgrounds = [];
  void getplaygrounds() {
    playgrounds = [];
    emit(GetPlayGroundsLoadingState());
    FirebaseFirestore.instance.collection('playgrounds').get().then((value) {
      value.docs.forEach((element) {
        playgrounds.add(PlayModel.fromJson(element.data()));
      });
      playgrounds.forEach((element) {
        print(element.pId);
      });
      emit(GetPlayGroundsSuccessState());
    }).catchError((error) {
      emit(GetPlayGroundsErrorState());
    });
  }

  void changecurrentmodel(var value) {
    currentregion = value;
    emit(ChangeCurrentModelState());
  }

  List<PlayModel> filteredPlayGrounds = [];
  void getfilteredplaygrounds(String address) {
    filteredPlayGrounds = [];
    emit(GetPlayFilteredGroundsLoadingState());
    FirebaseFirestore.instance.collection('playgrounds').get().then((value) {
      value.docs.forEach((element) {
        if (element['region'].toString() == (address)) {
          filteredPlayGrounds.add(PlayModel.fromJson(element.data()));
        }
      });
      emit(GetPlayFilteredSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPlayFilteredErrorState());
    });
  }

  bool chekPlaygroundexist(context) {
    bool isChecked = false;
    emit(CheckGroundLoadingState());
    showloadingdialog(context);
    FirebaseFirestore.instance.collection('playgrounds').get().then((value) {
      value.docs.forEach((element) {
        if (element.id == profilemodel!.userId) {
          isChecked = true;
        }
      });
      Navigator.pop(context);
      if (isChecked) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => const PlayGrounProfile())));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => const CreateProfileScreen())));
      }

      emit(CheckGroundSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CheckGroundErrorState());
    });
    return isChecked;
  }
}
