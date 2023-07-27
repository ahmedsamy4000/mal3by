import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal3by/constants_widgets/constants.dart';
import 'package:mal3by/constants_widgets/widgets.dart';
import 'package:mal3by/cubit/cubit.dart';
import 'package:mal3by/cubit/states.dart';
import 'package:mal3by/models/activity_model.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NewCubit.get(context);
    cubit.getActivities();
    return BlocBuilder<NewCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
              condition: state is! GetActivityLoadingState,
              fallback: (context) => fallbackwidget(),
              builder: (context) {
                return NewCubit.get(context).activities.isEmpty
                    ? noItem('No Activities')
                    : ListView.builder(
                        itemBuilder: (context, index) => activityItem(
                            NewCubit.get(context).activities[index], context),
                        itemCount: NewCubit.get(context).activities.length,
                      );
              }),
        );
      },
    );
  }
}

Widget activityItem(ActivityModel activityModel, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
    child: Card(
      color: Colors.grey[300],
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 80,
                height: 80,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Image(
                  image: AssetImage('images/bk.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.ballot_outlined,
                        color: appcolor,
                        size: 18,
                      ),
                      Expanded(
                        child: Text(
                          activityModel.playgroundname.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  space(10),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        color: appcolor,
                        size: 18,
                      ),
                      Text(
                        activityModel.activityDate.toString(),
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  space(10),
                  Row(
                    children: [
                      Icon(
                        Icons.stacked_line_chart_sharp,
                        color: appcolor,
                        size: 18,
                      ),
                      Text(activityModel.time.toString(),
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  NewCubit.get(context)
                      .deleteActivity(activityModel.activityId.toString());
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                )),
          )
        ],
      ),
    ),
  );
}
