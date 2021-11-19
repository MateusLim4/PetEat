import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/models/notification/save_notification.dart';
import 'package:peteat/shared/models/notification/save_notification_db.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';
import 'package:peteat/shared/widgets/notify/notify_modal.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<SaveNotification> notificacao;
  late List<ConfigUser> configuracoes;
  bool isLoading = false;

  @override
  void initState() {
    refreshConfigs();
    super.initState();
    isLoading = false;
  }

  Future refreshConfigs() async {
    setState(() => isLoading = true);
    notificacao = await SaveNotificationDB.instance.readAllConfigs();
    configuracoes = await AllConfigDatabase.instance.readAllConfigs();
    criaModal();
    setState(() => isLoading = false);
  }

  void criaModal() {
    var now = DateTime.now();
    configuracoes.forEach((element) {
      if (element.hora == now.hour &&
          element.minuto == now.minute &&
          element.diaSemanaId == now.weekday) {
        SaveNotificationDB.instance.create(SaveNotification(idMensagem: 1));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.titleWhite,
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const BackButton(
                color: AppColors.primary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 25),
                child: Text('Notificações', style: TextStyles.pinkTitle),
              ),
            ]),
          ),
        ),
      ),
      backgroundColor: AppColors.primary,
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/images/sleep.png')),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tudo calmo por enquanto...',
                        style: TextStyles.textWhiteBold,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
    );
  }

  Widget buildConfig() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: notificacao.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(5),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final notify = notificacao[index];

          return GestureDetector(
            onTap: () async {
              refreshConfigs();
            },
            child: ModalNotify(notify: notify, index: index),
          );
        },
      );
}
