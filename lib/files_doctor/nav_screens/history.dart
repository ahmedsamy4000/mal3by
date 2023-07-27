import 'package:flutter/material.dart';

import 'package:pharmazool/app/doctor/model/itemWidget.dart';
import 'package:pharmazool/app/patient/nav_screens/barcode.dart';
import 'package:pharmazool/app/patient/nav_screens/home_screen.dart';
import 'package:pharmazool/components/catalog-model.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  goToIndexPage(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const History()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BarCode()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "History",
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
          itemCount: CatalogModel.items.length,
          itemBuilder: (context, index) {
            return ItemWidget(item: CatalogModel.items[index]);
          }),
    );
  }
}