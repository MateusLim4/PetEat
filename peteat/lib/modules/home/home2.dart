import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peteat/functions/formata_hora.dart';
import 'package:peteat/functions/soma_quantidade.dart';
import 'package:peteat/modules/statistic/statistic_page.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/mqtt/mqtt.dart';
import 'package:peteat/shared/mqtt/mqtt_server.dart';
import 'package:peteat/shared/notify/notification.dart';
import 'package:peteat/shared/notify/notify_widget.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';
import 'package:peteat/shared/widgets/current.dart';

class FeederModal extends StatefulWidget {
  final dynamic config;
  final List<String> response;
  const FeederModal({Key? key, this.config, required this.response})
      : super(key: key);

  @override
  State<FeederModal> createState() => _FeederModalState();
}

class _FeederModalState extends State<FeederModal> {
  bool isLoading = false;
  late List<ConfigUser> configuracoes;
  late MQTTAppState currentAppState = MQTTAppState();

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
  int? index = 0;
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

    change();
    await trocaTamanho();
  }

  Future trocaTamanho() async {
    _animatedHeight != 0.0 ? _animatedHeight = 0.0 : _animatedHeight = 270;
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
                          configureAndConnect('testLB/intopic');

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
                                      var lista = somaQuantidade(configuracoes);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => Statistics(
                                          lista: lista,
                                        ),
                                      ));
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
        : Column(
            children: [
              Row(
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
                            child: Text('Configurar',
                                style: TextStyles.textWhiteBold),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.secondary)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                            configuracoes.isEmpty
                                ? 'N/a'
                                : '${configuracoes[index].alimento} g',
                            style: TextStyles.blueTextBold),
                        Text('Quantidade de ração\n definida',
                            style: TextStyles.textBlackLight,
                            textAlign: TextAlign.center),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              var payload = 'A:1.000';

                              publishMessage(payload);
                              createUniqueId();
                              antecipateNotification();
                            },
                            child:
                                Text('Antecipar', style: TextStyles.blueText),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: AppColors.secondary, width: 2.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
              CurrentFood()
            ],
          );
  }

  organizaHora(index, lista, now, diaInicial) {
    refreshConfigs();
    int count = 0;
    int menorHorario = 24;
    int menorMinuto = 60;
    int? indexHorario;
    int diferenca;

    if (diaInicial == index) {
      lista.forEach((element) {
        diferenca = 0;
        if (element[0] == index) {
          diferenca = element[1] - now.hour;
          if (diferenca >= 0 &&
              diferenca < menorHorario &&
              now.minute >= element[2]) {
            menorHorario = diferenca;
            indexHorario = count;
          } else if (diferenca == menorHorario) {
            diferenca = element[2] - now.minute;
            menorMinuto = lista[indexHorario!][2] - now.minute;
            if (diferenca >= 0 && diferenca < menorMinuto) {
              menorMinuto = diferenca;
              indexHorario = count;
            }
          }
        }
        count += 1;
      });
    } else {
      lista.forEach(
        (element) {
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
        },
      );
    }
    if (indexHorario != null) {
      return indexHorario;
    }
  }

  void definirHorario() {
    var now = DateTime.now();
    index = null;
    List lista = [];
    for (var element in configuracoes) {
      List subLista = [];
      subLista.add(element.diaSemanaId);
      subLista.add(element.hora);
      subLista.add(element.minuto);
      lista.add(subLista);
    }
    var agora = now.weekday;
    var diaInicial = agora;
    while (index == null) {
      switch (agora) {
        case 1:
          index = organizaHora(1, lista, now, diaInicial);
          break;
        case 2:
          index = organizaHora(2, lista, now, diaInicial);
          break;
        case 3:
          index = organizaHora(3, lista, now, diaInicial);
          break;
        case 4:
          index = organizaHora(4, lista, now, diaInicial);
          break;
        case 5:
          index = organizaHora(5, lista, now, diaInicial);
          break;
        case 6:
          index = organizaHora(6, lista, now, diaInicial);
          break;
        case 7:
          index = organizaHora(7, lista, now, diaInicial);
          agora = 0;
          break;
      }
      agora += 1;
    }
  }
}
