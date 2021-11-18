/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'package:flutter/material.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InfoChart extends StatefulWidget {
  final List data;
  const InfoChart({Key? key, required this.data}) : super(key: key);

  @override
  State<InfoChart> createState() => _InfoChartState();
}

class _InfoChartState extends State<InfoChart> {
  late List<ICData> _chartData;

  @override
  void initState() {
    double porcentagemConsumida = 0;
    double porcentagemNaoConsumida = 0;

    if (widget.data[1] != 0) {
      porcentagemConsumida =
          ((widget.data[1] - widget.data[0]) / widget.data[1]) * 100;
      porcentagemNaoConsumida = widget.data[0] / widget.data[1] * 100;
    }
    super.initState();

    _chartData = getChartData(porcentagemConsumida, porcentagemNaoConsumida);
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(
          text: 'Acompanhe a alimentação do seu pet!',
          textStyle: TextStyles.textBlack),
      legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.bottom),
      palette: const <Color>[
        Colors.grey,
        AppColors.secondary,
      ],
      series: <CircularSeries>[
        DoughnutSeries<ICData, String>(
            dataSource: _chartData,
            xValueMapper: (ICData data, _) => data.nome,
            yValueMapper: (ICData data, _) => data.data,
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)))
      ],
    );
  }

  List<ICData> getChartData(porcentagemConsumida, porcentagemNaoConsumida) {
    final List<ICData> chartData = [
      ICData('Não consumido', porcentagemConsumida.toInt()),
      ICData('Consumido', porcentagemNaoConsumida.toInt()),
    ];
    return chartData;
  }
}

class ICData {
  ICData(this.nome, this.data);
  final String? nome;
  final int? data;
}
