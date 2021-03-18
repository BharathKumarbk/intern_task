import 'dart:convert';

import 'package:interview_task/models/lecture_model.dart';

class WeakModel {
  final String day;
  final List<LectureModel> lec;
  WeakModel({
    this.day,
    this.lec,
  });

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'lec': lec?.map((x) => x.toMap())?.toList(),
    };
  }

  factory WeakModel.fromMap(Map<String, dynamic> map) {
    return WeakModel(
      day: map['day'],
      lec: List<LectureModel>.from(
          map['lec']?.map((x) => LectureModel.fromMap(x))),
    );
  }
}
