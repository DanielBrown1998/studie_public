// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  final int timeStart;
  final int timeEnd;
  final String description;
  final String discipline;
  bool checked;
  final int? uid;
  final String daysWeek;
  Task({
    int? timeEnd,
    required this.timeStart,
    required this.description,
    required this.discipline,
    this.checked = false,
    this.uid,
    required this.daysWeek,
  }) : timeEnd = timeEnd ?? timeStart + 1;

  Task copyWith({
    int? timeStart,
    int? timeEnd,
    String? description,
    String? discipline,
    bool? checked,
    int? uid,
    String? daysWeek,
  }) {
    return Task(
      timeStart: timeStart ?? this.timeStart,
      timeEnd: timeEnd ?? this.timeEnd,
      description: description ?? this.description,
      discipline: discipline ?? this.discipline,
      checked: checked ?? this.checked,
      uid: uid ?? this.uid,
      daysWeek: daysWeek ?? this.daysWeek,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timeStart': timeStart,
      'timeEnd': timeEnd,
      'description': description,
      'discipline': discipline,
      'checked': checked,
      'uid': uid,
      'daysWeek': daysWeek,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      timeStart: map['timeStart'] as int,
      timeEnd: map['timeEnd'] as int,
      description: map['description'] as String,
      discipline: map['discipline'] as String,
      checked: map['checked'] as bool,
      uid: map['uid'] != null ? map['uid'] as int : null,
      daysWeek: map['daysWeek'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(timeStart: $timeStart, timeEnd: $timeEnd, description: $description, discipline: $discipline, checked: $checked, uid: $uid, daysWeek: $daysWeek)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.timeStart == timeStart &&
        other.timeEnd == timeEnd &&
        other.description == description &&
        other.discipline == discipline &&
        other.checked == checked &&
        other.uid == uid &&
        other.daysWeek == daysWeek;
  }

  @override
  int get hashCode {
    return timeStart.hashCode ^
        timeEnd.hashCode ^
        description.hashCode ^
        discipline.hashCode ^
        checked.hashCode ^
        uid.hashCode ^
        daysWeek.hashCode;
  }
}
