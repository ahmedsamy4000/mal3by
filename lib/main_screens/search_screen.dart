import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unicons/unicons.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:mal3by/main_screens/main_page.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NewCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        backgroundColor: appcolor,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onSubmitted: (searcher) {
              cubit.searchplaygrounds(searcher);
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(UniconsLine.search),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<NewCubit, AppStates>(builder: (context, state) {
            return ConditionalBuilder(
                fallback: (context) {
                  return const Center(
                    child: Text('search is empty'),
                  );
                },
                condition: cubit.searchgrounds.isNotEmpty,
                builder: (context) {
                  return ListView.builder(
                    itemBuilder: (context, index) =>
                        mainItem(cubit.searchgrounds[index], context),
                    itemCount: cubit.searchgrounds.length,
                  );
                });
          }),
        ))
      ]),
    );
  }
}
