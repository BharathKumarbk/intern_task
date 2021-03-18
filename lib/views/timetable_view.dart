import 'package:flutter/material.dart';
import 'package:interview_task/models/week_model.dart';
import 'package:interview_task/views/widgets.dart';

class TimeTableView extends StatelessWidget {
  final WeakModel weak;

  const TimeTableView({Key key, this.weak}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: weak.lec.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      weak.lec[index].timing,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textBold("Subject Code",
                              "${weak.lec[index].subject_code}"),
                          textBold(
                              "Subject", "${weak.lec[index].subject_name}"),
                          textBold(
                              "Faculty", "${weak.lec[index].teacher_name}"),
                          textBold(
                              "Period Type", "${weak.lec[index].period_type}"),
                          textBold("Subject Type",
                              "${weak.lec[index].subject_type}"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
