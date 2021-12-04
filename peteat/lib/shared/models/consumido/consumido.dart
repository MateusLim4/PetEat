const String tableConsumo = 'consumo';

class QuantConsumidaFields {
  static final List<String> values = [id, idDiaAtual, quantConsumida];

  static const String id = '_id';
  static const String idDiaAtual = 'horaAtual';
  static const String quantConsumida = 'quantConsumida';
}

class QuantConsumida {
  final int? id;
  final int? idDiaAtual;
  final double? quantConsumida;

  const QuantConsumida(
      {this.id, required this.idDiaAtual, required this.quantConsumida});

  QuantConsumida copy({int? id, int? idDiaAtual, double? quantConsumida}) =>
      QuantConsumida(
          id: id ?? this.id,
          idDiaAtual: idDiaAtual ?? this.idDiaAtual,
          quantConsumida: quantConsumida ?? this.quantConsumida);

  static QuantConsumida fromJson(Map<String, Object?> json) => QuantConsumida(
      id: json[QuantConsumidaFields.id] as int?,
      idDiaAtual: json[QuantConsumidaFields.idDiaAtual] as int?,
      quantConsumida: json[QuantConsumidaFields.quantConsumida] as double?);

  Map<String, Object?> toJson() => {
        QuantConsumidaFields.id: id,
        QuantConsumidaFields.idDiaAtual: idDiaAtual,
        QuantConsumidaFields.quantConsumida: quantConsumida
      };
}
