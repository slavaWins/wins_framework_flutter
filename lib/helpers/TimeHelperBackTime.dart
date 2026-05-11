 class TimeHelperBackTime {

  static String formatDateTimeFull(DateTime? dateTimeInput) {
    if (dateTimeInput == null) return "NA TIME";

    final dateTime = dateTimeInput;
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // Если разница меньше минуты
    if (difference.inSeconds < 60) {
      if (difference.inSeconds < 5) {
        return "только что";
      } else {
        return "${difference.inSeconds} сек назад";
      }
    }

    // Если разница меньше часа
    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return "$minutes ${_getMinutesWord(minutes)} назад";
    }

    // Если разница меньше 24 часов
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return "$hours ${_getHoursWord(hours)} назад";
    }

    // Если разница меньше 7 дней
    if (difference.inDays < 7) {
      final days = difference.inDays;
      return "$days ${_getDaysWord(days)} назад";
    }

    // Если больше 7 дней - показываем полную дату
    return _getFullDate(dateTime, now);
  }

// Вспомогательный метод для склонения слова "минута"
   static  String _getMinutesWord(int minutes) {
    if (minutes % 10 == 1 && minutes % 100 != 11) {
      return "минуту";
    } else if ((minutes % 10 == 2 || minutes % 10 == 3 || minutes % 10 == 4) &&
        (minutes % 100 < 10 || minutes % 100 > 20)) {
      return "минуты";
    } else {
      return "минут";
    }
  }

// Вспомогательный метод для склонения слова "час"
   static String _getHoursWord(int hours) {
    if (hours % 10 == 1 && hours % 100 != 11) {
      return "час";
    } else if ((hours % 10 == 2 || hours % 10 == 3 || hours % 10 == 4) &&
        (hours % 100 < 10 || hours % 100 > 20)) {
      return "часа";
    } else {
      return "часов";
    }
  }

// Вспомогательный метод для склонения слова "день"
   static String _getDaysWord(int days) {
    if (days % 10 == 1 && days % 100 != 11) {
      return "день";
    } else if ((days % 10 == 2 || days % 10 == 3 || days % 10 == 4) &&
        (days % 100 < 10 || days % 100 > 20)) {
      return "дня";
    } else {
      return "дней";
    }
  }

// Полная дата
   static String _getFullDate(DateTime dateTime, DateTime now) {
    final months = [
      'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
      'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
    ];

    final weekdays = [
      'Воскресенье', 'Понедельник', 'Вторник', 'Среда',
      'Четверг', 'Пятница', 'Суббота'
    ];

    final day = dateTime.day;
    final month = months[dateTime.month - 1];
    final year = dateTime.year;
    final weekday = weekdays[dateTime.weekday % 7];

    if (year == now.year) {
      return "$day $month, $weekday";
    } else {
      return "$day $month $year г.";
    }
  }
}