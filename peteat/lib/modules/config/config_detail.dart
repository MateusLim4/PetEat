import 'package:flutter/material.dart';
import 'package:peteat/functions/formata_hora.dart';
import 'package:peteat/modules/config/add_edit_config.dart';
import 'package:peteat/modules/notification/notification.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';

class ConfigDetailPage extends StatefulWidget {
  final int configId;
  const ConfigDetailPage({Key? key, required this.configId}) : super(key: key);

  @override
  _ConfigDetailPageState createState() => _ConfigDetailPageState();
}

class _ConfigDetailPageState extends State<ConfigDetailPage> {
  late ConfigUser configuracoes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshConfigs();
  }

  Future refreshConfigs() async {
    setState(() => isLoading = true);

    configuracoes =
        await AllConfigDatabase.instance.readConfig(widget.configId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(152),
          child: Container(
            height: 152,
            color: AppColors.titleWhite,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const BackButton(color: AppColors.primary),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 25),
                        child: Text('Detalhes ', style: TextStyles.pinkTitle),
                      ),
                      Row(
                        children: [
                          editButton(),
                          deleteButton(),
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  color: AppColors.titleWhite,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Horário definido: ',
                                  style: TextStyles.blueText),
                              Text(
                                  '${formataHora(configuracoes.hora, configuracoes.minuto)}',
                                  style: TextStyles.textBlack),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Dia: ', style: TextStyles.blueText),
                              Text('${configuracoes.diaSemana}',
                                  style: TextStyles.textBlack),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Quantidade de ração(g): ',
                                  style: TextStyles.blueText),
                              Text('${configuracoes.alimento}',
                                  style: TextStyles.textBlack),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(
        Icons.edit_outlined,
        color: AppColors.primary,
      ),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditConfig(configuracoes: configuracoes),
        ));

        refreshConfigs();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete, color: AppColors.primary),
        onPressed: () async {
          await AllConfigDatabase.instance.delete(widget.configId);
          await deleteConfigNotification();
          Navigator.of(context).pop();
        },
      );
}
