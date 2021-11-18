import 'package:flutter/material.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';
import 'package:peteat/shared/widgets/charts/dounuts_chart.dart';

class ChartDisplay extends StatefulWidget {
  final int quantConsumida;
  final int quantDefinida;
  const ChartDisplay({
    Key? key,
    required this.quantConsumida,
    required this.quantDefinida,
  }) : super(key: key);

  @override
  State<ChartDisplay> createState() => _ChartDisplayState();
}

class _ChartDisplayState extends State<ChartDisplay> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final list = [];
    list.add(widget.quantConsumida);
    list.add(widget.quantDefinida);

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: cardWidget(
                  size,
                  'Total de programado',
                  widget.quantDefinida,
                  TextStyles.greyTextBold,
                ),
              ),
              cardWidget(
                size,
                'Quantidade consumida',
                widget.quantConsumida,
                TextStyles.blueTextBold,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: size.height * 0.46,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  color: AppColors.titleWhite,
                  borderRadius: BorderRadius.circular(3)),
              child: InfoChart(data: list),
            ),
          )
        ],
      ),
    );
  }

  Widget cardWidget(size, texto, valor, estilo) => Container(
        height: size.height * 0.18,
        width: size.width * 0.45,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${valor}g', style: estilo),
                Text(
                  texto,
                  textAlign: TextAlign.center,
                  style: TextStyles.textBlackLight,
                )
              ],
            ),
          ),
        ),
      );
}
