const String tableConfigs = 'messages';

class SavedNotificationDB {
  static final List<String> values = [id, mensagem];

  static const String id = '_id';
  static const String mensagem = 'mensagem';
}

class SaveNotification {
  final int? id;
  final String? mensagem;

  const SaveNotification({
    this.id,
    required this.mensagem,
  });

  SaveNotification copy({
    int? id,
    String? idMensagem,
  }) =>
      SaveNotification(
        id: id ?? this.id,
        mensagem: mensagem ?? this.mensagem,
      );

  static SaveNotification fromJson(Map<String, Object?> json) =>
      SaveNotification(
        id: json[SavedNotificationDB.id] as int?,
        mensagem: json[SavedNotificationDB.mensagem] as String?,
      );

  Map<String, Object?> toJson() => {
        SavedNotificationDB.id: id,
        SavedNotificationDB.mensagem: mensagem,
      };
}
