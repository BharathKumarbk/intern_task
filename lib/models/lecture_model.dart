class LectureModel {
  final String duration;
  final int period_id;
  final String period_type;
  final String subject_code;
  final String subject_type;
  final String subject_name;
  final String teacher_id;
  final String teacher_name;
  final String timing;

  LectureModel({
    this.duration,
    this.period_id,
    this.teacher_name,
    this.period_type,
    this.subject_code,
    this.subject_type,
    this.subject_name,
    this.teacher_id,
    this.timing,
  });

  Map<String, dynamic> toMap() {
    return {
      'duration': duration,
      'period_id': period_id,
      'period_type': period_type,
      'subject_code': subject_code,
      'subject_type': subject_type,
      'subject_name': subject_name,
      'teacher_id': teacher_id,
      'timing': timing,
      'teacher_name': teacher_name,
    };
  }

  factory LectureModel.fromMap(Map<String, dynamic> map) {
    return LectureModel(
      duration: map['duration'],
      period_id: map['period_id'],
      period_type: map['period_type'],
      subject_code: map['subject_code'],
      subject_type: map['subject_type'],
      subject_name: map['subject_name'],
      teacher_id: map['teacher_id'],
      timing: map['timing'],
      teacher_name: map['teacher_name'],
    );
  }
}
