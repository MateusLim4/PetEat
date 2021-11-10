// Função para adiantar a hora para que a comida caia imediatamente
import 'formata_hora.dart';

adiantar() {
  int hours;
  int minutes;

  DateTime now = DateTime.now();
  hours = now.hour.toInt();
  minutes = now.minute.toInt() + 5;
  if (minutes > 59) {
    minutes = minutes - 60;
    hours = hours + 1;
  }
  formataHora(hours, minutes);
}
