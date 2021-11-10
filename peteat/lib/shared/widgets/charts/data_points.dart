class Quant {
  String nome;
  double quantDefinida;

  Quant(this.nome, this.quantDefinida);
}

void gerateData() {
  Quant('Alimentado', 80);
  Quant('Sobrou', 100);
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
