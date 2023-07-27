import 'package:flutter/material.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: const [
          TextField(
            decoration: InputDecoration(
                hintText: 'Number Of Hours',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12.0,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Number Of Hours',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12.0,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Number Of Hours',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12.0,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Number Of Hours',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12.0,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
        ]),
      ),
    );
  }
}
