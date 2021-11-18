const String tableConfigs = 'messages';

class SavedNotificationDB {
  static final List<String> values = [id, idMensagem];

  static const String id = '_id';
  static const String idMensagem = 'horaAtual';
}

class SaveNotification {
  final int? id;
  final int? idMensagem;

  const SaveNotification({
    this.id,
    required this.idMensagem,
  });

  SaveNotification copy({
    int? id,
    int? idMensagem,
  }) =>
      SaveNotification(
        id: id ?? this.id,
        idMensagem: idMensagem ?? this.idMensagem,
      );

  static SaveNotification fromJson(Map<String, Object?> json) =>
      SaveNotification(
        id: json[SavedNotificationDB.id] as int?,
        idMensagem: json[SavedNotificationDB.idMensagem] as int?,
      );

  Map<String, Object?> toJson() => {
        SavedNotificationDB.id: id,
        SavedNotificationDB.idMensagem: idMensagem,
      };
}
