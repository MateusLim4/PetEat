import '../my-globals.dart';

class DayWeek {
  var message = '';

  void diaSemana(bool domingo) {
    var lista = [domingo, segunda, terca, quarta, quinta, sexta, sabado];
    var week = [
      'Domingo',
      'Segunda',
      'Terça',
      'Quarta',
      'Quinta',
      'Sexta',
      'Sábado'
    ];
    var days = [];

    int count = 0;
    for (var element in lista) {
      if (element == true) {
        days.add(week[count]);
      }
      count = count + 1;
    }

    switch (days.length) {
      case 0:
        message = 'Sem data definida';
        break;
      case 1:
        message = '${days[0]}';
        break;
      case 2:
        if (days[0] == 'Sábado' && days[1] == 'Domingo') {
          message = "Apenas aos fins de semana";
        } else {
          message = '${days[0]} e ${days[1]}';
        }
        break;
      case 3:
        message = '${days[0]}, ${days[1]} e ${days[2]}';
        break;
      case 4:
        message = '${days[0]}, ${days[1]},${days[2]} e ${days[3]}';
        break;
      case 5:
        if (days[0] == 'Segunda' &&
            days[1] == 'Terça' &&
            days[2] == 'Quarta' &&
            days[3] == 'Quinta' &&
            days[4] == 'Sexta') {
          message = "Apenas nos dias úteis";
        } else {
          message =
              '${days[0]}, ${days[1]}, ${days[2]}, ${days[3]} ,${days[4]}';
        }
        break;
      case 6:
        message =
            '${days[0]}, ${days[1]}, ${days[2]}, ${days[3]}, ${days[4]} e ${days[5]}';
        break;
      case 7:
        message = 'Todos os dias';
        break;
      default:
    }
  }
}
