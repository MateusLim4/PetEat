// Função para deixar horas formatadas
formataHora(hora, minuto) {
  String formatado = '';
  if (hora < 10 && minuto < 10) {
    formatado = '0${hora}:0${minuto}';
  } else if (hora >= 10 && minuto < 10) {
    formatado = '${hora}:0${minuto}';
  } else if (hora < 10 && minuto > 10) {
    formatado = '0${hora}:${minuto}';
  } else {
    formatado = '${hora}:${minuto}';
  }
  return formatado;
}
