import 'dart:convert';

class HourModel {
  final String? hora;
  final String? semana;

  HourModel({
    this.hora,
    this.semana,
  });

  HourModel copyWith({String? hour, String? semana}) {
    return HourModel(
      hora: hour ?? this.hora,
      semana: semana ?? this.semana,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hora': hora,
      'semana': semana,
    };
  }

  factory HourModel.fromMap(Map<String, dynamic> map) {
    return HourModel(
      hora: map['hora'],
      semana: map['semana'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HourModel.fromJson(String source) =>
      HourModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HourModel(hour: $hora, semana: $semana)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HourModel && other.hora == hora && other.semana == semana;
  }

  @override
  int get hashcode {
    return hora.hashCode ^ semana.hashCode;
  }
}
