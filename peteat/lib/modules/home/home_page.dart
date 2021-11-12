import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:peteat/modules/config/add_edit_config.dart';

import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/models/user_model.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';
import 'package:peteat/shared/widgets/logout/logout_modal.dart';

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
  int index = 0;

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
                      child: Text('Permitir',
                          style: TextStyle(color: AppColors.secondary)),
                    )
                  ],
                ));
      }
    });
  }

  @override
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
                            onPressed: () {},
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
                  ? OpsPage()
                  : FeederModal(
                      index: index,
                    ),
        ),
        floatingActionButton: isLoading
            ? null
            : configuracoes.isEmpty
                ? FloatingActionButton(
                    backgroundColor: AppColors.secondary,
                    onPressed: () async {
                      isTrue = true;
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddEditConfig(),
                        ),
                      );
                      refreshConfigs();

                      setState(() {});
                    },
                    child: Icon(Icons.add),
                  )
                : null);
  }

  void organizar() async {
    var horario = TimeOfDay.now();
    List listaHoras = [];
    var hora;
    var minuto = 0;
    int diferencaMin = 0;
    int menorDiferencaMin = 100;
    int menorDiferenca = 100;
    int count = 0;
    int diferenca = 0;
    var lista = await AllConfigDatabase.instance.readAllConfigs();
    List inteira = [];
    lista.forEach((element) {
      List sub = [];
      sub.add(element.hora);
      sub.add(element.minuto);
      inteira.add(sub);
    });
    //Encontra as menores diferenças de hora
    inteira.forEach((element) {
      if (horario.hour <= element[0]) {
        diferenca = element[0] - horario.hour;
        if (diferenca > 0 && diferenca < menorDiferenca) {
          menorDiferenca = diferenca;
          hora = element[0];
        }
      }
    });
    inteira.forEach((element) {
      if (element[0] == hora) {
        index = count;
        listaHoras.add(count);
        count += 1;
      }
    });
    count = 0;
    listaHoras.forEach((element) {
      diferencaMin = inteira[element][1] - horario.minute;
      if (diferencaMin > 0 && diferencaMin < menorDiferenca) {
        menorDiferencaMin = diferencaMin;
        index = count;
      }
      count += 1;
    });

    index = count;
    refreshConfigs();
  }
}
