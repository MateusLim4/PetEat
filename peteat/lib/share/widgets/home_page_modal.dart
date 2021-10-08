import 'package:flutter/material.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';

class ModalHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 500,
                color: AppColors.titleWhite,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 40),
                      child: Container(
                          child: Text('Conectar dispositivo',
                              style: TextStyles.textBlackBold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              'Nenhum dispositivo encontrado...',
                              style: TextStyles.textBlackLight,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        child: Text(
                            'Pressione “Buscar” para procurar novos dispositivos...',
                            style: TextStyles.textBlackLight),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.search,
                          )),
                    )
                  ]),
                ),
              );
            },
          );
        });
  }
}
