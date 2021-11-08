import 'package:flutter/material.dart';

final String tableConfigs = 'configs';

class ConfigFields {
  static final List<String> values = [
    id,
    hora,
    minuto,
    diaSemana,
    diaSemanaId,
    alimento,
    notificacaoId,
  ];

  static final String id = '_id';
  static final String hora = 'hora';
  static final String minuto = 'minuto';
  static final String diaSemana = 'dia_semana';
  static final String diaSemanaId = 'dia_semana_id';
  static final String alimento = 'alimento';
  static final String notificacaoId = 'notificacao_id';
}

class ConfigUser {
  final int? id;
  final int? hora;
  final int? minuto;
  final String? diaSemana;
  final int? diaSemanaId;
  final String? alimento;
  final int? notificacaoId;

  const ConfigUser(
      {this.id,
      required this.hora,
      required this.minuto,
      required this.diaSemana,
      required this.diaSemanaId,
      required this.alimento,
      required this.notificacaoId});

  ConfigUser copy({
    int? id,
    int? hora,
    int? minuto,
    String? diaSemana,
    int? diaSemanaId,
    String? alimento,
    int? notificacaoId,
  }) =>
      ConfigUser(
        id: id ?? this.id,
        alimento: alimento ?? this.alimento,
        diaSemana: diaSemana ?? this.diaSemana,
        diaSemanaId: diaSemanaId ?? this.diaSemanaId,
        hora: hora ?? this.hora,
        minuto: minuto ?? this.minuto,
        notificacaoId: notificacaoId ?? this.notificacaoId,
      );

  static ConfigUser fromJson(Map<String, Object?> json) => ConfigUser(
      id: json[ConfigFields.id] as int?,
      hora: json[ConfigFields.hora] as int?,
      minuto: json[ConfigFields.minuto] as int?,
      diaSemana: json[ConfigFields.diaSemana] as String?,
      diaSemanaId: json[ConfigFields.diaSemanaId] as int?,
      alimento: json[ConfigFields.alimento] as String?,
      notificacaoId: json[ConfigFields.notificacaoId] as int?);

  Map<String, Object?> toJson() => {
        ConfigFields.id: id,
        ConfigFields.hora: hora,
        ConfigFields.minuto: minuto,
        ConfigFields.diaSemana: diaSemana,
        ConfigFields.diaSemanaId: diaSemanaId,
        ConfigFields.alimento: alimento,
        ConfigFields.notificacaoId: notificacaoId
      };
}
