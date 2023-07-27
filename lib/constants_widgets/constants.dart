import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/detailed_screens/detailed_bk_page.dart';
import 'package:mal3by/models/order_model.dart';
import 'package:mal3by/models/playgroundmodel.dart';
import 'package:mal3by/models/user_model.dart';

UserModel? profilemodel = UserModel(
    userId: '',
    name: '',
    email: '',
    image: '',
    address: '',
    phone: '',
    region: '');

PlayModel? mymodel;
Color appcolor = const Color.fromRGBO(0, 102, 0, 1);
void navigateto(BuildContext context, Widget mywidget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => mywidget));
}

Widget appTextField1(
    String hintTitle, var controller, IconData icon, void Function() fun) {
  return TextField(
    onTap: fun,
    controller: controller,
    decoration: InputDecoration(
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        hintText: hintTitle,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey))),
  );
}

Widget appregisterTextField1(String hintTitle, var controller, IconData icon,
    context, TextInputType type, void Function() fun) {
  return TextFormField(
    onTap: fun,
    controller: controller,
    validator: (controller) {
      if (controller!.isEmpty) {
        return 'please enter your $hintTitle';
      } else {
        return null;
      }
    },
    keyboardType: type,
    decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        hintText: hintTitle,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey))),
  );
}

String currentregion = 'Cairo';
List<String> regions = [
  'Cairo',
  'Alexandria',
  'Gizeh',
  'Shubra El-Kheima',
  'Port Said',
  'Suez',
  'Luxor',
  'al-Mansura',
  'El-Mahalla El-Kubra',
  'Tanta',
  'Asyut',
  'Ismailia',
  'Fayyum',
  'Zagazig',
  'Aswan',
  'Damietta',
  'Damanhur',
  'al-Minya',
  'Beni Suef',
  'Qena',
  'Sohag',
  'Hurghada',
  '6th of October City',
  'Shibin El Kom',
  'Banha',
  'Kafr el-Sheikh',
  'Arish',
  'Mallawi',
  '10th of Ramadan City',
  'Bilbais',
  'Marsa Matruh',
  'Idfu',
  'Mit Ghamr',
  'Al-Hamidiyya',
  'Desouk',
  'Qalyub',
  'Abu Kabir',
  'Kafr el-Dawwar',
  'Matareya',
  'Giza',
];

Widget regionItem(context) {
  return InkWell(
    onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DetailedBgScreen()));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black),
                child: const Image(
                  image: AssetImage('images/bk.jpg'),
                  fit: BoxFit.cover,
                ),
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
                        children: const [
                          Icon(
                            Icons.ballot_outlined,
                            color: Colors.green,
                          ),
                          Text(
                            'Play ground name',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          Text(
                            'address',
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
          ],
        ),
      ),
    ),
  );
}

Widget bookitem(OrderModel model, int time, bool booked, context, String myId,
    String playgroundname) {
  return InkWell(
    onTap: () {
      if (model.booked == false) {
        NewCubit.get(context).showMyDialog(
          context,
          booked,
          myId.toString(),
          model.time.toString(),
          DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(model.orderdate.toString()))),
          playgroundname,
        );
      }
    },
    child: Container(
      height: 150,
      width: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.grey[300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: model.booked == false ? Colors.red : appcolor),
            child: Text(
              (model.time).toString(),
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            model.name == null ? 'available' : model.name.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    ),
  );
}

Widget profilebookitem(
    OrderModel model, int time, bool booked, context, String myId) {
  return InkWell(
    onTap: () {
      if (model.booked == false) {
        NewCubit.get(context).showMyprofileDialog(
          context,
          booked,
          myId.toString(),
          model.time.toString(),
          DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(model.orderdate.toString()))),
        );
      }
    },
    child: Container(
      height: 150,
      width: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.grey[300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: model.booked == false ? Colors.red : appcolor),
            child: Text(
              (model.time).toString(),
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            model.name == null ? 'available' : model.name.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    ),
  );
}
