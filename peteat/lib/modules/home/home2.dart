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

  @override
  void initState() {
    super.initState();
    refreshConfigs();
  }

  Future refreshConfigs() async {
    setState(() => isLoading = true);

    this.configuracoes = await AllConfigDatabase.instance.readAllConfigs();

    setState(() => isLoading = false);
  }

  @override
  double _animatedHeight = 0;

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
                                        '${configuracoes[0].hora}:${configuracoes[0].minuto}',
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
                                    Text('${configuracoes[0].alimento} g',
                                        style: TextStyles.blueTextBold),
                                    Text('Quantidade de ração\n definida',
                                        style: TextStyles.textBlackLight,
                                        textAlign: TextAlign.center),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          hora.adiantar();
                                          initState();
                                          setState() {}
                                          ;
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
          )
        ],
      ),
    );
  }
}
