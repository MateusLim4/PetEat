import 'package:flutter/material.dart';

const String tableConfigs = 'configs';

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

  static const String id = '_id';
  static const String hora = 'hora';
  static const String minuto = 'minuto';
  static const String diaSemana = 'dia_semana';
  static const String diaSemanaId = 'dia_semana_id';
  static const String alimento = 'alimento';
  static const String notificacaoId = 'notificacao_id';
}

class ConfigUser {
  final int? id;
  final int? hora;
  final int? minuto;
  final String? diaSemana;
  final int? diaSemanaId;
  final int? alimento;
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
    int? alimento,
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
      alimento: json[ConfigFields.alimento] as int?,
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
