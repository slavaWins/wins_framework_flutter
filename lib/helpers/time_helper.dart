String formatDateTime(DateTime? dateTimeInput, bool isAddingTime ) {
  if(dateTimeInput==null)return "NA TIME";

  var dateTime = dateTimeInput.toLocal();
  var now = DateTime.now();



  final today = DateTime(now.year, now.month, now.day);
  //final yesterday = DateTime(now.year, now.month, now.day - 1);
  final dateNow = DateTime(dateTime.year, dateTime.month, dateTime.day);


  String fulltime = "";
  if (now.difference(dateTime).inHours < 20 || isAddingTime) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    fulltime =  '$hours:$minutes';
  }

  if (now.difference(dateTime).inHours < 20 ) {
    return fulltime;
  }

  /*
  else if (date == yesterday) {
    return 'Вчера';
  }
  */
  // Если в течение последних 7 дней - возвращаем день недели (например, "-Пт")
  else if (now.difference(dateTime).inDays < 2) {
    final weekdays = ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];


    return '${weekdays[dateTime.weekday % 7]} '+fulltime;
  }
  // Если больше недели назад - возвращаем дату (например, "-27.11.2021")
  else {
    final months = [
      'янв',
      'фев',
      'мар',
      'апр',
      'мая',
      'июн',
      'июл',
      'авг',
      'сен',
      'окт',
      'ноя',
      'дек',
    ];

    final day = dateTime.day;
    final month = months[dateTime.month - 1];
    final year = dateTime.year;

    if (year == now.year) {
      return '$day $month';
    } else {
      return '$day $month $year г. ' +fulltime;
    }
  }
}

String formatOnlyTime(DateTime? dateTimeInput) {
  var dateTime = dateTimeInput ?? DateTime.now();
  dateTime = dateTime.toLocal();

  final hours = dateTime.hour.toString().padLeft(2, '0');
  final minutes = dateTime.minute.toString().padLeft(2, '0');
  return '$hours:$minutes';
}
