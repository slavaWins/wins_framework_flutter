// 'статья', 'статьи', 'статей'
String declineWord(int? number, String form1, String form2, String form5) {

  number = number ?? 0;
  number = number.abs(); // для отрицательных чисел

  if (number % 10 == 1 && number % 100 != 11) {
    return form1; // 1 статья
  } else if (number % 10 >= 2 && number % 10 <= 4 &&
      (number % 100 < 10 || number % 100 >= 20)) {
    return form2; // 2 статьи
  } else {
    return form5; // 5 статей
  }
}


String TipografLebedeva(String text) {

    const sp = '\u00A0';
    String result = text;

    // 1. Частицы и предлоги
    final particles = [
      'несмотря на', 'из-за', '—', 'из-под', // многословные — первыми
      'самому', 'самой', 'самих',
      'также', 'тоже',
      'ведь', 'даже', 'лишь', 'либо', 'хотя',
      'через', 'после', 'перед', 'между', 'около',
      'вдоль', 'среди', 'внутри', 'вместо', 'вокруг',
      'под', 'над', 'при', 'про', 'для', 'без',
      'это', 'эта', 'эти', 'этот',
      'он', 'она', 'они', 'мы', 'вы',
      'со', 'во', 'ко', 'но', 'по', 'за', 'из',
      'от', 'до', 'на', 'об', 'не', 'ни', 'бы',
      'и', 'в', 'с', 'к', 'а', 'о', 'у',
    ]..sort((a, b) => b.length.compareTo(a.length));

    for (final p in particles) {
      result = result.replaceAllMapped(
        RegExp(
          '(?<=[\\wа-яёА-ЯЁ,.!?»"])[\\s\u00A0]+($p)[\\s\u00A0]+(?=[\\wа-яёА-ЯЁ])',
          caseSensitive: false,
          unicode: true,
        ),
            (m) => ' ${m.group(1)}\u00A0',
      );
    }

   // result = result.replaceAll(" -", sp+"-");
   // result = result.replaceAll(" —", sp+"—");
/*
    // 2. Инициалы: И. И. Иванов → И.\u00A0И.\u00A0Иванов
    result = result.replaceAllMapped(
      RegExp(r'([А-ЯЁA-Z]\.)[\s\u00A0]+([А-ЯЁA-Z]\.?)[\s\u00A0]*', unicode: true),
          (m) => '${m.group(1)}\u00A0${m.group(2)}\u00A0',
    );

    // 3. Числа с единицами измерения
    result = result.replaceAllMapped(
      RegExp(r'(\d+)[\s\u00A0]+(%|₽|€|\$|км|м|см|мм|кг|г|л|мл|шт|с|мин|ч|°C|°F)',
          unicode: true),
          (m) => '${m.group(1)}\u00A0${m.group(2)}',
    );

*/
    // 4. Короткие слова (1–2 буквы) в начале предложения
    result = result.replaceAllMapped(
      RegExp(
        r'(^|(?<=[.!?]\s{0,3}))([А-ЯЁа-яёA-Za-z]{1,2})[\s\u00A0]+(?=[А-ЯЁа-яёA-Za-z])',
        multiLine: true,
        unicode: true,
      ),
          (m) => '${m.group(1)}${m.group(2)}\u00A0',
    );

    //print("TipografLebedeva fix: " + result.replaceAll('\u00A0', '_'));
    return result;
  }