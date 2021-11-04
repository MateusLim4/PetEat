import 'package:flutter/material.dart';

final String tableConfigs = 'configs';

class ConfigFields {
  static final List<String> values = [id, horario, diaSemana, alimento];

  static final String id = '_id';
  static final String horario = 'horario';
  static final String diaSemana = 'dia_semana';
  static final String alimento = 'alimento';
}

class ConfigUser {
  final int? id;
  final String horario;
  final String diaSemana;
  final String alimento;

  const ConfigUser(
      {this.id,
      required this.horario,
      required this.diaSemana,
      required this.alimento});

  ConfigUser copy({
    int? id,
    String? horario,
    String? diaSemana,
    String? alimento,
  }) =>
      ConfigUser(
          id: id ?? this.id,
          alimento: alimento ?? this.alimento,
          horario: horario ?? this.horario,
          diaSemana: diaSemana ?? this.diaSemana);

  static ConfigUser fromJson(Map<String, Object?> json) => ConfigUser(
        id: json[ConfigFields.id] as int?,
        horario: json[ConfigFields.horario] as String,
        diaSemana: json[ConfigFields.diaSemana] as String,
        alimento: json[ConfigFields.alimento] as String,
      );

  Map<String, Object?> toJson() => {
        ConfigFields.id: id,
        ConfigFields.horario: horario,
        ConfigFields.diaSemana: diaSemana,
        ConfigFields.alimento: alimento,
      };
}
