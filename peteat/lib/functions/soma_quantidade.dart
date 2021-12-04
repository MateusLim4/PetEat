import 'package:peteat/shared/models/config_user.dart';

somaQuantidade(configuracoes) {
  List lista = [];
  int count = 1;
  while (count != 8) {
    int? soma = 0;
    for (var element in configuracoes) {
      if (count == element.diaSemanaId) {
        int alimento = element.alimento.toInt();
        soma = alimento + soma!;
      }
    }
    lista.add(soma);
    count += 1;
  }
  print(lista);
  return lista;
}

somaQuantidade2(configuracoes) {
  List lista = [];
  int count = 1;
  while (count != 8) {
    int? soma = 0;
    for (var element in configuracoes) {
      if (count == element.idDiaAtual) {
        int alimento = element.quantConsumida.toInt();
        soma = alimento + soma!;
      }
    }
    lista.add(soma);
    count += 1;
  }
  print(lista);
  return lista;
}
