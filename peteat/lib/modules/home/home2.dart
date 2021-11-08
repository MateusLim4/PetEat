import 'package:flutter/material.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/themes/app_colors.dart';
import 'package:peteat/shared/themes/app_text_style.dart';
import 'package:peteat/shared/widgets/timewidget/hours.dart';

class FeederModal extends StatefulWidget {
  // final UserModel user;
  final dynamic config;
  const FeederModal({Key? key, this.config}) : super(key: key);

  @override
  State<FeederModal> createState() => _FeederModalState();
}

class _FeederModalState extends State<FeederModal> {
  bool isLoading = false;
  late List<ConfigUser> configuracoes;
  Future refreshConfigs() async {
    setState(() => isLoading = true);

    configuracoes = await AllConfigDatabase.instance.readAllConfigs();

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    refreshConfigs();
  }

  @override
  double _animatedHeight = 200;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var hora = Hour();

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                    onTap: () => setState(() {
                          _animatedHeight != 0.0
                              ? _animatedHeight = 0.0
                              : _animatedHeight = 200.0;
                        }),
                    child: Column(
                      children: [
                        Container(
                            height: size.height * 0.1,
                            width: size.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  topRight: Radius.circular(3)),
                              color: AppColors.secondary,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 15, right: 15, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child:
                                        Image.asset('assets/images/racao.png'),
                                  ),
                                  Text('Alimentador 01',
                                      style: TextStyles.textWhite),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/statistics',
                                      );
                                    },
                                    child: Text(
                                      'Relatório',
                                      style: TextStyles.textWhiteBold,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: AppColors.titleWhite,
                                          width: 2.0),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    )),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.titleWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(2, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                        '${configuracoes[index].hora}:${configuracoes[index].minuto}',
                                        style: TextStyles.blueTextBold),
                                    Text('Proxima liberação de\n ração',
                                        style: TextStyles.textBlackLight,
                                        textAlign: TextAlign.center),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            "/config",
                                          );
                                        },
                                        child: Text('Configurar',
                                            style: TextStyles.textWhiteBold),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColors.secondary)),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('${configuracoes[index].alimento} g',
                                        style: TextStyles.blueTextBold),
                                    Text('Quantidade de ração\n definida',
                                        style: TextStyles.textBlackLight,
                                        textAlign: TextAlign.center),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          hora.adiantar();
                                        },
                                        child: Text('Antecipar',
                                            style: TextStyles.blueText),
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: AppColors.secondary,
                                              width: 2.0),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                  height: _animatedHeight,
                )
              ],
            ),
          ),
          ElevatedButton(onPressed: organizar, child: Text('atualizar'))
        ],
      ),
    );
  }

  void organizar() async {
    refreshConfigs();
    // var horario = TimeOfDay.now();
    // int hora;
    // var minuto;
    // int menorDiferenca = 100;
    // int count = 0;
    // var lista = await AllConfigDatabase.instance.readAllConfigs();
    // List inteira = [];
    // lista.forEach((element) {
    //   List sub = [];
    //   sub.add(element.hora);
    //   sub.add(element.minuto);
    //   inteira.add(sub);
    // });
    // inteira.forEach((element) {
    //   if (horario.hour == element[0]) {
    //     var diferenca = minuto - element[0];
    //     if (diferenca < menorDiferenca && diferenca > 0) {
    //       menorDiferenca = diferenca;

    //       index = count;

    //       print(index);
    //     }
    //   }
    //   count += 1;
    // });
  }
}
