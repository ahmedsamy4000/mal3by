import 'package:flutter/material.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/detailed_screens/detailed_regions.dart';

class RegionsScreen extends StatelessWidget {
  const RegionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: Colors.grey,
                ),
            itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) =>
                            DetailedRegions(name: regions[index]))));
                  },
                  title: Text(
                    regions[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
            itemCount: regions.length),
      ),
    );
  }
}
