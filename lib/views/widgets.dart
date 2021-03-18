import 'package:flutter/material.dart';
import 'package:interview_task/components/constants.dart';

Widget textBold(String title, String content) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(
              "$title",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )),
        Text(" : "),
        Expanded(
            flex: 4,
            child: Text(
              "$content",
              style: TextStyle(fontSize: 18.0, color: kBlack),
            )),
      ],
    ),
  );
}

Widget loadingWidget() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Loading",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        CircularProgressIndicator()
      ],
    ),
  );
}
