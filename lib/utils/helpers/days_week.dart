enum AllWeekDays {
  initial,
  segundaFeira,
  tercaFeira,
  quartaFeira,
  quintaFeira,
  sextaFeira,
  sabado,
  domingo,
}

extension AllWeekDaysExtension on AllWeekDays {
  String get nome {
    switch (this) {
      case AllWeekDays.initial:
        return "Orientacoes";
      case AllWeekDays.segundaFeira:
        return "Segunda-feira";
      case AllWeekDays.tercaFeira:
        return "Terça-feira";
      case AllWeekDays.quartaFeira:
        return "Quarta-feira";
      case AllWeekDays.quintaFeira:
        return "Quinta-feira";
      case AllWeekDays.sextaFeira:
        return "Sexta-feira";
      case AllWeekDays.sabado:
        return "Sábado";
      case AllWeekDays.domingo:
        return "Domingo";
    }
  }
}

AllWeekDays getWeekdayByNumber(int num) {
  switch (num) {
    case 0:
      return AllWeekDays.initial;
    case 1:
      return AllWeekDays.segundaFeira;
    case 2:
      return AllWeekDays.tercaFeira;
    case 3:
      return AllWeekDays.quartaFeira;
    case 4:
      return AllWeekDays.quintaFeira;
    case 5:
      return AllWeekDays.sextaFeira;
    case 6:
      return AllWeekDays.sabado;
    case 7:
      return AllWeekDays.domingo;
    default:
      throw ArgumentError('Invalid weekday number: $num');
  }
}

int getNumberByWeekDay(AllWeekDays weekday) {
  switch (weekday) {
    case AllWeekDays.initial:
      return 0;
    case AllWeekDays.segundaFeira:
      return 1;
    case AllWeekDays.tercaFeira:
      return 2;
    case AllWeekDays.quartaFeira:
      return 3;
    case AllWeekDays.quintaFeira:
      return 4;
    case AllWeekDays.sextaFeira:
      return 5;
    case AllWeekDays.sabado:
      return 6;
    case AllWeekDays.domingo:
      return 7;
  }
}
