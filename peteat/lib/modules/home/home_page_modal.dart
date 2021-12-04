import 'package:flutter/material.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';

class ModalHomeWidget extends StatefulWidget {
  final dynamic configuracoes;
  const ModalHomeWidget({Key? key, this.configuracoes}) : super(key: key);

  @override
  State<ModalHomeWidget> createState() => _ModalHomeWidgetState();
}

class _ModalHomeWidgetState extends State<ModalHomeWidget> {
  @override
  String message2 = "Pressione “Buscar” para procurar novos dispositivos.";
  String buttonmessage = "Buscar";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FloatingActionButton(
        backgroundColor: AppColors.secondary,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Center(
                  child: Container(
                height: 500,
                color: AppColors.titleWhite,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 50, bottom: 50),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        isLoading
                            ? CircularProgressIndicator(
                                color: AppColors.secondary)
                            : Container(
                                child: Text('Conectar dispositivo',
                                    style: TextStyles.textBlackBold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            child: Text('$message2',
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
                                        const Icon(
                                          Icons.search,
                                        ),
                                        Text(buttonmessage)
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ));
            },
          );
        });
  }
}
