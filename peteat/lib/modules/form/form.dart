import 'package:flutter/material.dart';
import 'package:peteat/shared/themes/app_colors.dart';
import 'package:peteat/shared/themes/app_text_style.dart';
import 'package:peteat/shared/widgets/timewidget/clock.dart';

class FormularioWidget extends StatefulWidget {
  final String? horario;
  final String? diaSemana;
  final String? alimento;
  final ValueChanged<String> onChangedHorario;
  final ValueChanged<String> onChangedDiaSemana;
  final ValueChanged<String> onChangedAlimento;

  const FormularioWidget(
      {Key? key,
      this.horario,
      this.diaSemana,
      this.alimento,
      required this.onChangedHorario,
      required this.onChangedDiaSemana,
      required this.onChangedAlimento})
      : super(key: key);

  @override
  State<FormularioWidget> createState() => _FormularioWidgetState();
}

class _FormularioWidgetState extends State<FormularioWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController timeCtl = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10, top: 20),
      child: Container(
          height: size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.titleWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(2, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child:
                    Text('Definir configurações', style: TextStyles.blueText),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: buildHora(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: buildSemana(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: buildAlimento(),
              ),
            ],
          )),
    );
  }

  Widget buildHora() => TextFormField(
        initialValue: widget.horario,
        maxLength: 5,
        validator: (horario) =>
            horario != null && horario.isEmpty ? 'Preencha esse campo!' : null,
        onChanged: widget.onChangedHorario,
      );

  Widget buildSemana() => TextFormField(
        initialValue: widget.diaSemana,
        maxLength: 20,
        validator: (diaSemana) => diaSemana != null && diaSemana.isEmpty
            ? 'Preencha esse campo!'
            : null,
        onChanged: widget.onChangedDiaSemana,
        decoration: const InputDecoration(
          labelText: 'Definir dia da Semana',
        ),
      );

  Widget buildAlimento() => TextFormField(
        keyboardType: TextInputType.number,
        initialValue: widget.alimento,
        maxLength: 4,
        validator: (alimento) => alimento != null && alimento.isEmpty
            ? 'Preencha esse campo!'
            : null,
        onChanged: widget.onChangedAlimento,
        decoration: const InputDecoration(
          labelText: 'Quantidade de alimento (g)',
        ),
      );
}
