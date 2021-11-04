import 'package:flutter/material.dart';
import 'package:peteat/modules/form/form.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/themes/app_colors.dart';
import 'package:peteat/shared/themes/app_text_style.dart';

class AddEditConfig extends StatefulWidget {
  final ConfigUser? configuracoes;
  const AddEditConfig({Key? key, this.configuracoes}) : super(key: key);

  @override
  _AddEditConfigState createState() => _AddEditConfigState();
}

class _AddEditConfigState extends State<AddEditConfig> {
  final _formKey = GlobalKey<FormState>();
  late String horario;
  late String diaSemana;
  late String alimento;

  @override
  void initState() {
    super.initState();
    horario = widget.configuracoes?.horario ?? '';
    diaSemana = widget.configuracoes?.diaSemana ?? '';
    alimento = widget.configuracoes?.alimento ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.titleWhite,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButton(color: AppColors.primary),
                    Text('Alimentador 01 ', style: TextStyles.pinkTitle),
                    buildButton()
                  ]),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: FormularioWidget(
              horario: horario,
              diaSemana: diaSemana,
              alimento: alimento,
              onChangedAlimento: (alimento) =>
                  setState(() => this.alimento = alimento),
              onChangedDiaSemana: (diaSemana) =>
                  setState(() => this.diaSemana = diaSemana),
              onChangedHorario: (horario) =>
                  setState(() => this.horario = horario)),
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid =
        horario.isNotEmpty && diaSemana.isNotEmpty && alimento.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: AppColors.titleWhite,
          primary: isFormValid ? null : AppColors.stroke,
        ),
        onPressed: addOrUpdate,
        child: Text('Salvar'),
      ),
    );
  }

  void addOrUpdate() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.configuracoes != null;

      if (isUpdating) {
        await update();
      } else {
        await add();
      }

      Navigator.of(context).pop();
    }
  }

  Future update() async {
    final configs = widget.configuracoes!.copy(
      alimento: alimento,
      diaSemana: diaSemana,
      horario: horario,
    );

    await AllConfigDatabase.instance.update(configs);
  }

  Future add() async {
    final configs = ConfigUser(
      alimento: alimento,
      diaSemana: diaSemana,
      horario: horario,
    );

    await AllConfigDatabase.instance.create(configs);
  }
}
