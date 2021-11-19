import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:peteat/modules/config/add_edit_config.dart';
import 'package:peteat/modules/config/config_detail.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';
import 'package:peteat/shared/widgets/timewidget/time_widget.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late List<ConfigUser> configuracoes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshConfigs();
  }

  @override
  // void dispose() {
  //   AllConfigDatabase.instance.close();
  //   super.dispose();
  // }

  Future refreshConfigs() async {
    setState(() => isLoading = true);

    configuracoes = await AllConfigDatabase.instance.readAllConfigs();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.titleWhite,
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const BackButton(
                color: AppColors.primary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 25),
                child: Text('Configurações ', style: TextStyles.pinkTitle),
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
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 200,
                          width: 200,
                          child: Image.asset('assets/images/confused.png')),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'ONDE ESTÃO MINHAS CONFIGURAÇÕES?',
                          style: TextStyles.textWhiteBold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'Clique no botão abaixo e defina novas configurações',
                        style: TextStyles.textWhite,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : buildConfig(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditConfig(),
            ),
          );
          refreshConfigs();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildConfig() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: configuracoes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(5),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final config = configuracoes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ConfigDetailPage(configId: config.id!),
              ));

              refreshConfigs();
            },
            child: ConfigCardWidget(config: config, index: index),
          );
        },
      );
}
