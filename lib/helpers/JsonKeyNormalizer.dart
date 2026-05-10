class JsonKeyNormalizer {
  static dynamic normalize(dynamic json) {
    if (json is Map) {
      final result = <String, dynamic>{};
      json.forEach((key, value) {
        final newKey = _toCamelCase(key.toString());
        result[newKey] = normalize(value);
      });
      return result;
    } else if (json is List) {
      return json.map((e) => normalize(e)).toList();
    }
    return json;
  }

  static String _toCamelCase(String str) {
    if (str.isEmpty) return str;
    return str[0].toLowerCase() + str.substring(1);
  }
}
