import 'package:interview_task/models/week_model.dart';

class TimeTable {
  final int clas;
  final String day;
  final String error;
  final String section;
  final String semester;
  final String stream_id;
  final List uptimetable;
  final List<WeakModel> weekdays;
  TimeTable({
    this.clas,
    this.day,
    this.error,
    this.section,
    this.semester,
    this.stream_id,
    this.uptimetable,
    this.weekdays,
  });

  Map<String, dynamic> toMap() {
    return {
      'clas': clas,
      'day': day,
      'error': error,
      'section': section,
      'semester': semester,
      'stream_id': stream_id,
      'uptimetable': uptimetable,
      'weekdays': weekdays?.map((x) => x.toMap())?.toList(),
    };
  }

  factory TimeTable.fromMap(Map<String, dynamic> map) {
    return TimeTable(
      clas: map['clas'],
      day: map['day'],
      error: map['error'],
      section: map['section'],
      semester: map['semester'],
      stream_id: map['stream_id'],
      uptimetable: List.from(map['uptimetable']),
      weekdays: List<WeakModel>.from(
          map['weekdays']?.map((x) => WeakModel.fromMap(x))),
    );
  }
}
