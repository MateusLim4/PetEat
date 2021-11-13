const String tableConfigs = 'configs';

class ConfigFields {
  static final List<String> values = [id, horaAtual, minutoAtual];

  static const String id = '_id';
  static const String horaAtual = 'horaAtual';
  static const String minutoAtual = 'minutoAtual';
}

class CurrentHour {
  final int? id;
  final int? horaAtual;
  final int? minutoAtual;

  const CurrentHour({
    this.id,
    required this.horaAtual,
    required this.minutoAtual,
  });

  CurrentHour copy({
    int? id,
    int? horaAtual,
    int? minutoAtual,
  }) =>
      CurrentHour(
        id: id ?? this.id,
        horaAtual: horaAtual ?? this.horaAtual,
        minutoAtual: minutoAtual ?? this.minutoAtual,
      );

  static CurrentHour fromJson(Map<String, Object?> json) => CurrentHour(
        id: json[ConfigFields.id] as int?,
        horaAtual: json[ConfigFields.horaAtual] as int?,
        minutoAtual: json[ConfigFields.minutoAtual] as int?,
      );

  Map<String, Object?> toJson() => {
        ConfigFields.id: id,
        ConfigFields.horaAtual: horaAtual,
        ConfigFields.minutoAtual: minutoAtual,
      };
}
