import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peteat/functions/formata_hora.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';

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
  int? index = null;
  double _animatedHeight = 0;
  bool _visible = true;

  Future change() async {
    if (_animatedHeight == 0) {
      _visible = false;
    } else {
      _visible = true;
    }
  }

  Future trocaStatus() async {
    refreshConfigs();

    await change();
    trocaTamanho();
  }

  Future trocaTamanho() async {
    _animatedHeight != 0.0 ? _animatedHeight = 0.0 : _animatedHeight = 217.5;
  }

  @override
  Widget build(BuildContext context) {
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
                          definirHorario();
                          trocaStatus();
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cardContent(index),
                      ],
                    ),
                  ),
                  height: _animatedHeight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardContent(index) {
    return _visible
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Column(
                  children: [
                    Text(
                        configuracoes.isEmpty
                            ? 'N/a'
                            : '${formataHora(configuracoes[index].hora, configuracoes[index].minuto)}',
                        style: TextStyles.blueTextBold),
                    Text('Proxima liberação de\n ração',
                        style: TextStyles.textBlackLight,
                        textAlign: TextAlign.center),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _animatedHeight = 0;
                          });

                          Navigator.pushNamed(
                            context,
                            "/config",
                          );
                        },
                        child:
                            Text('Configurar', style: TextStyles.textWhiteBold),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.secondary)),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                        configuracoes.isEmpty
                            ? 'N/a'
                            : '${configuracoes[0].alimento} g',
                        style: TextStyles.blueTextBold),
                    Text('Quantidade de ração\n definida',
                        style: TextStyles.textBlackLight,
                        textAlign: TextAlign.center),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text('Antecipar', style: TextStyles.blueText),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: AppColors.secondary, width: 2.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]);
  }

  organizaHora(index, lista, now, diaInicial) {
    int count = 0;
    int menorHorario = 24;
    int menorMinuto = 60;
    int? indexHorario;
    int diferenca;

    if (diaInicial == index) {
      lista.forEach((element) {
        if (element[0] == index) {
          diferenca = element[1] - now.hour;
          if (diferenca >= 0 && diferenca < menorHorario) {
            menorHorario = element[1];
            indexHorario = count;
          } else if (diferenca == menorHorario) {
            diferenca = element[2] - now.minute;
            menorMinuto = lista[indexHorario!][2];
            if (diferenca >= 0 && diferenca < menorMinuto) {
              menorMinuto = diferenca;
              indexHorario = count;
            }
          }
        }
        count += 1;
      });
    } else {
      lista.forEach((element) {
        if (element[0] == index) {
          diferenca = now.hour - element[1];
          if (diferenca < menorHorario) {
            menorHorario = element[1];
            indexHorario = count;
          } else if (diferenca == menorHorario) {
            diferenca = now.minute - element[2];
            menorMinuto = lista[indexHorario!][2];
            if (diferenca < menorMinuto) {
              menorMinuto = diferenca;
              indexHorario = count;
            }
          }
        }
        count += 1;
      });

      return indexHorario;
    }
  }

  void definirHorario() {
    var now = DateTime.now();
    List lista = [];
    for (var element in configuracoes) {
      List subLista = [];
      subLista.add(element.diaSemanaId);
      subLista.add(element.hora);
      subLista.add(element.minuto);
      lista.add(subLista);
    }
    print(index);
    var agora = now.weekday;
    var diaInicial = agora;
    while (index == null) {
      switch (agora) {
        case 0:
          setState(() {
            index = organizaHora(0, lista, now, diaInicial);
          });

          break;
        case 1:
          setState(() {
            index = organizaHora(1, lista, now, diaInicial);
          });

          break;
        case 2:
          setState(() {
            index = organizaHora(2, lista, now, diaInicial);
          });

          break;
        case 3:
          setState(() {
            index = organizaHora(3, lista, now, diaInicial);
          });

          break;
        case 4:
          setState(() {
            index = organizaHora(4, lista, now, diaInicial);
          });

          break;
        case 5:
          setState(() {
            index = organizaHora(5, lista, now, diaInicial);
          });

          break;
        case 6:
          setState(() {
            index = organizaHora(6, lista, now, diaInicial);
          });

          agora = -1;
          break;
      }
      agora += 1;
      print(index);
    }
  }
}
