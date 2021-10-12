import 'package:flutter/material.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';

class ModalHomeWidget extends StatefulWidget {
  const ModalHomeWidget({Key? key}) : super(key: key);

  @override
  State<ModalHomeWidget> createState() => _ModalHomeWidgetState();
}

class _ModalHomeWidgetState extends State<ModalHomeWidget> {
  var message1 = "Nenhum dispositivo encontrado... \n";
  var message2 = "Pressione “Buscar” para procurar novos dispositivos...";
  var buttonmessage = "Buscar";

  @override
  Widget build(BuildContext context) {
    void _buscar() {
      setState(() {
        message1 = "";
        message2 = "Buscando novos dispositivos";
        buttonmessage = "Buscando...";
      });
    }

    final size = MediaQuery.of(context).size;

    return FloatingActionButton(
        backgroundColor: AppColors.secondary,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 500,
                color: AppColors.titleWhite,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 50, bottom: 50),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            child: Text('Conectar dispositivo',
                                style: TextStyles.textBlackBold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            child: Text(
                                '$message1'
                                '$message2',
                                style: TextStyles.textBlackLight),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColors.secondary)),
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                        ),
                                        Text('$buttonmessage')
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              );
            },
          );
        });
  }
}
