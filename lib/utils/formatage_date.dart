String customdate(DateTime dateTime) {
  String jour = formatingDay(dateTime.day);
  String mois = formatingMonth(dateTime.month);
  String annee = dateTime.year.toString();

  String date = jour + " " + mois + " " + annee;

  return date;
}

String formatingDay(int day) {
  if (day < 10) {
    return "0$day";
  }
  return "$day";
}

String formatingMonth(int month) {
  switch (month) {
    case 1:
      return "jan";
    case 2:
      return "fév";
    case 3:
      return "mars";
    case 4:
      return "avr";
    case 5:
      return "mai";
    case 6:
      return "juin";
    case 7:
      return "juil";
    case 8:
      return "août";
    case 9:
      return "sept";
    case 10:
      return "oct";
    case 11:
      return "nov";
    default:
      return "déc";
  }
}
