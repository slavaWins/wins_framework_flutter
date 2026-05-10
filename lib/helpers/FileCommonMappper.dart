import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/src/media_type.dart';

class FileCommonMappper {

  static String _getFileExtension(Uint8List bytes) {
    // Проверяем PNG сигнатуру: 137 80 78 71 13 10 26 10
    if (bytes.length >= 8 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47 &&
        bytes[4] == 0x0D &&
        bytes[5] == 0x0A &&
        bytes[6] == 0x1A &&
        bytes[7] == 0x0A) {
      return 'png';
    }

    // Проверяем JPEG сигнатуру: FF D8 FF
    if (bytes.length >= 3 &&
        bytes[0] == 0xFF &&
        bytes[1] == 0xD8 &&
        bytes[2] == 0xFF) {
      return 'jpg';
    }

    // Проверяем GIF сигнатуру: GIF87a или GIF89a
    if (bytes.length >= 6 &&
        ((bytes[0] == 0x47 && bytes[1] == 0x49 && bytes[2] == 0x46 &&
            bytes[3] == 0x38 && bytes[4] == 0x37 && bytes[5] == 0x61) ||
            (bytes[0] == 0x47 && bytes[1] == 0x49 && bytes[2] == 0x46 &&
                bytes[3] == 0x38 && bytes[4] == 0x39 && bytes[5] == 0x61))) {
      return 'gif';
    }

    // Проверяем WEBP сигнатуру: RIFF ???? WEBP
    if (bytes.length >= 12 &&
        bytes[0] == 0x52 && bytes[1] == 0x49 && bytes[2] == 0x46 && bytes[3] == 0x46 &&
        bytes[8] == 0x57 && bytes[9] == 0x45 && bytes[10] == 0x42 && bytes[11] == 0x50) {
      return 'webp';
    }

    return 'jpg'; // дефолтное значение
  }

  static String _getMediaType(String extension) {
    switch (extension) {
      case 'png':
        return 'png';
      case 'gif':
        return 'gif';
      case 'webp':
        return 'webp';
      case 'jpg':
      default:
        return 'jpeg';
    }
  }

  static List<MultipartFile> ConvertUint8ListToMultipartFiles(
      List<Uint8List> images,
      String fieldName, // 'Files'
      ) {
    return images.asMap().entries.map((entry) {
      final index = entry.key;
      final imageBytes = entry.value;

      final extension = _getFileExtension(imageBytes);
      final mediaType = _getMediaType(extension);

      return http.MultipartFile.fromBytes(
        fieldName,
        imageBytes,
        filename: 'image_${DateTime.now().millisecondsSinceEpoch}_$index.$extension',
        contentType: MediaType('image', mediaType),
      );
    }).toList();
  }
}