import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:interview_task/controllers/api_key.dart';
import 'package:interview_task/models/timeTable_model.dart';
import 'package:interview_task/models/week_model.dart';

class ApiService extends ChangeNotifier {
  WeakModel _weakModel;

  WeakModel get weakModel => _weakModel;

  final uri = Uri(
      scheme: 'https',
      host: "www.presencex.com",
      path: "REVA/school/gettimetable");

  Future getApiData(String date, String day) async {
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'section': 'A',
      'semester': '3',
      'request_date': date,
      'stream': 'str003',
      'api_key': ApiKey.key,
      'school_id': 'SCH10100'
    });
    try {
      if (response.statusCode == 200) {
        String result = response.body;
        Map<String, dynamic> map = json.decode(result);
        TimeTable timeTable = TimeTable.fromMap(map);
        print(day.substring(1, 3));
        WeakModel weak = timeTable.weekdays.firstWhere((element) =>
            element.day.toUpperCase().substring(0, 3) == day.toUpperCase());
        _weakModel = weak;

        notifyListeners();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
