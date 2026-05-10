import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';

class CryptoHelper {
  static final _algorithm = AesGcm.with256bits(nonceLength: 12);

  // Шифрование
  static Future<String> encrypt(String plainText, String secretKey) async {
    final key = _deriveKey(secretKey);
    final secretKeyObj = SecretKey(key);

    final plainBytes = utf8.encode(plainText);

    final secretBox = await _algorithm.encrypt(
      plainBytes,
      secretKey: secretKeyObj,
    );

    // Собираем: nonce + mac (tag) + cipher
    final result = <int>[];
    result.addAll(secretBox.nonce);
    result.addAll(secretBox.mac.bytes);
    result.addAll(secretBox.cipherText);

    return base64.encode(result);
  }

  // Расшифровка
  static Future<String?> decrypt(String? encryptedText, String secretKey) async {
    if(encryptedText==null)return encryptedText;

    final key = _deriveKey(secretKey);
    final secretKeyObj = SecretKey(key);

    final fullData = base64.decode(encryptedText);

    // Разбираем: nonce (12) + mac (16) + cipher
    final nonce = fullData.sublist(0, 12);
    final macBytes = fullData.sublist(12, 28);
    final cipherText = fullData.sublist(28);

    final secretBox = SecretBox(
      cipherText,
      nonce: nonce,
      mac: Mac(macBytes),
    );

    final plainBytes = await _algorithm.decrypt(
      secretBox,
      secretKey: secretKeyObj,
    );

    return utf8.decode(plainBytes);
  }

  // Преобразуем строковый ключ в 32 байта
  static List<int> _deriveKey(String secretKey) {
    return sha256.convert(utf8.encode(secretKey)).bytes;
  }
}