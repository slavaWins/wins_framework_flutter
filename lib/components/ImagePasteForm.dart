import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pasteboard/pasteboard.dart';

class ImagePasteForm {
  late FocusNode focusNode;

  Uint8List? bytes;

  TextEditingController? textController = TextEditingController();

  ValueChanged<Uint8List>? OnPasteImage;

  ValueChanged<bool>? OnKeySend;

  FocusNode MakeFocusNode() {
    focusNode = FocusNode(
      onKeyEvent: (node, event) {
        final enterPressedWithShift =
            event is KeyDownEvent &&
            event.physicalKey == PhysicalKeyboardKey.enter &&
            HardwareKeyboard.instance.physicalKeysPressed.any(
              (key) => <PhysicalKeyboardKey>{
                PhysicalKeyboardKey.shiftLeft,
                PhysicalKeyboardKey.shiftRight,
              }.contains(key),
            );

        if (enterPressedWithShift) {
          if (OnKeySend != null) {
            OnKeySend!(true);
          }

          return KeyEventResult.handled;
        }

        if (event is KeyDownEvent) {
          // Проверяем комбинацию для вставки
          final isPasteShortcut = _isPasteShortcut(event);

          if (isPasteShortcut) {
            _checkClipboardForImage();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
    );

    return focusNode;
  }

  Future<void> AddAtachImageFromPickerMulty() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickMultiImage(
        limit: 5,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (pickedFile != null) {
        for (int i = 0; i < pickedFile.length; i++) {
          bytes = await pickedFile[i].readAsBytes();
          OnPasteImage!(this.bytes!);
        }
      }
    } catch (e) {
      print("Ошибка при выборе изображения: $e");
    }
  }

  Future<void> AddAtachImageFromPicker() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (pickedFile != null) {
        bytes = await pickedFile.readAsBytes();
        OnPasteImage!(this.bytes!);
      }
    } catch (e) {
      print("Ошибка при выборе изображения: $e");
    }
  }

  void _pasteImageFromClipboard() async {
    print("image paste1");
    final bytes = await Pasteboard.image;

    this.bytes = bytes;
    OnPasteImage!(this.bytes!);
  }

  void _pasteTextClipboard(String text) {
    print("text paste1");
    if (textController == null) return;

    final currentText = textController!.text;
    final selection = textController!.selection;

    // Вставляем текст в текущую позицию курсора
    final newText = currentText.replaceRange(
      selection.start,
      selection.end,
      text,
    );

    textController!.text = newText;

    // Обновляем позицию курсора после вставки
    final newCursorPosition = selection.start + text.length;
    textController!.selection = selection.copyWith(
      baseOffset: newCursorPosition,
      extentOffset: newCursorPosition,
    );
  }

  // Функция для проверки комбинации вставки
  bool _isPasteShortcut(KeyEvent event) {
    final isMetaPressed = HardwareKeyboard.instance.isMetaPressed;
    final isControlPressed = HardwareKeyboard.instance.isControlPressed;

    // Для Mac: Cmd + V
    // Для Windows/Linux: Ctrl + V
    if ((isMetaPressed || isControlPressed) &&
        event.logicalKey == LogicalKeyboardKey.keyV) {
      return true;
    }

    return false;
  }

  void _checkClipboardForImage() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);

    if (clipboardData?.text?.length == 0 || clipboardData?.text == null) {
      //wind sup
      // Если текста нет, пробуем вставить картинку
      print("image paste");
      _pasteImageFromClipboard();
    } else {
      // Если изображения нет, проверяем текст

      _pasteTextClipboard(clipboardData!.text!);
    }
  }
}
