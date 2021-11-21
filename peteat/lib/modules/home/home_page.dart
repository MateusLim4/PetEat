import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:peteat/modules/config/add_edit_config.dart';
import 'package:peteat/modules/notification/notification_page.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/models/user_model.dart';
import 'package:peteat/shared/mqtt/mqtt.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';
import 'package:peteat/shared/widgets/logout/logout_button.dart';
import 'home1.dart';
import 'home2.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ConfigUser> configuracoes;
  bool isLoading = false;

  @override
  void initState() {
    refreshConfigs();
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Permitir notificações'),
                  content: const Text(
                      'Nosso aplicativo gostaria de enviar notificações para você'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Não permitir',
                            style: TextStyle(color: AppColors.buttonRed))),
                    TextButton(
                      onPressed: () => AwesomeNotifications()
                          .requestPermissionToSendNotifications()
                          .then((_) => Navigator.pop(context)),
                      child: const Text('Permitir',
                          style: TextStyle(color: AppColors.secondary)),
                    )
                  ],
                ));
      }
    });
  }

  Future refreshConfigs() async {
    setState(() => isLoading = true);

    configuracoes = await AllConfigDatabase.instance.readAllConfigs();

    setState(() => isLoading = false);
  }

  final homeController = HomeController();
  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(152),
          child: Container(
            height: 152,
            color: AppColors.titleWhite,
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(children: [
                          Logout(
                              user: ModalRoute.of(context)!.settings.arguments
                                  as UserModel),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('Hello, ',
                                style: TextStyles.pinkTitleThin),
                          ),
                          Text(
                            widget.user.name,
                            style: TextStyles.pinkTitle,
                          ),
                          TextButton(
                            child: const Icon(Icons.notifications,
                                size: 40, color: AppColors.grey),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationPage()));
                            },
                          ),
                        ]),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : configuracoes.isEmpty
                  ? const OpsPage()
                  : Column(
                      children: [
                        const FeederModal(),
                      ],
                    ),
        ),
        floatingActionButton: isLoading
            ? null
            : configuracoes.isEmpty
                ? FloatingActionButton(
                    backgroundColor: AppColors.secondary,
                    onPressed: () async {
                      isTrue = true;
                      configureAndConnect();
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddEditConfig(),
                        ),
                      );
                      refreshConfigs();
                      setState(() {});
                    },
                    child: const Icon(Icons.add),
                  )
                : null);
  }
}
