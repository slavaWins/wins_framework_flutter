import 'package:flutter/material.dart';

import '../helpers/ApiException.dart';

class ErrorHandleWidget extends StatefulWidget {
  final bool isMini;

  const ErrorHandleWidget({super.key, required this.isMini});

  @override
  State<ErrorHandleWidget> createState() => ErrorHandleWidgetState();
}

class ErrorHandleWidgetState extends State<ErrorHandleWidget> {
  static ErrorHandleWidgetState? link;

  late bool isMini = false;

  String? errorText;

  bool isLoading = false;

  static void ShowErrorAuto(String msg) {
    if(link==null)return;
    link?.ShowError(msg);
  }

  static void ShowErrorExeption(Object exception) {
    link?.ShowErrorExeptionLocal(exception);
  }

  static void SetLoading(bool loading) {
    if (link == null) return;
    if (!link!.mounted) return;

    link!.SetLoadingLocal(loading);
  }

  void SetLoadingLocal(bool loading) {
    if (!mounted) return;
    if (!context.mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //иначе во время билда выполняется
      if (!mounted) return;
      setState(() {
        isLoading = loading;

        if (loading) {
          errorText = null;
        }
      });
    });
  }

  void ShowError(String msg) {
    if(!mounted)return;
    print("ShowError: $msg");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //иначе во время билда выполняется
      if (!mounted) return;
      setState(() {
        errorText = msg;
        isLoading = false; // Сбрасываем загрузку при ошибке
      });
    });
  }

  void ShowErrorExeptionLocal(Object exception) {
    String errorMessage;

    // Пытаемся привести к ApiException
    if (exception is ApiException) {
      errorMessage = "Error ${exception.code}: ${exception.message}";
      if (exception.code == 400) {
        errorMessage = "Проблема с подключением к сети. " + errorMessage;
      }
    }
    // Если это не ApiException, но можно попробовать распарсить код ошибки
    else if (exception.toString().contains(RegExp(r'\b\d{3}\b'))) {
      // Ищем трехзначные коды (HTTP статусы) в тексте ошибки
      final regex = RegExp(r'\b(\d{3})\b');
      final match = regex.firstMatch(exception.toString());
      if (match != null) {
        errorMessage = "Error ${match.group(1)}: ${exception.toString()}";
      } else {
        errorMessage = exception.toString();
      }
    } else {
      errorMessage = exception.toString();
    }

    print("ShowErrorExeption: $errorMessage");
    setState(() {
      errorText = errorMessage;
      isLoading = false; // Сбрасываем загрузку при ошибке
    });
  }

  void OnClickDetails(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Ошибка сервиса'),
        content: Text(errorText ?? "na"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Ок'),
          ),
        ],
      ),
    );
  }

  void HideError() {
    setState(() {
      errorText = null;
    });
  }

  @override
  void initState() {
    super.initState();
    link = this;
  }

  @override
  void dispose() {
    if (link == this) {
      link = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    link = this;

    return Column(
      mainAxisSize: MainAxisSize.min,


      children: [
        if (isLoading)
          Row(

            spacing: 12,
            children: [
              Container(
                height: 29,
                width: 29,
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  strokeAlign: 5,
                ),
              ),

              if (widget.isMini)
                Text("Загрузка", style: TextStyle(fontSize: 13)),
            ],
          ),

        // Текст ошибки
        if (errorText != null && !isLoading)
          !widget.isMini
              ? Container(
            padding: EdgeInsets.all(3),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Colors.red.withAlpha(200),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          )
              : IconButton(
            onPressed: () {
              OnClickDetails(context);
            },
            icon: Icon(
              Icons.error_outline,
              color: Colors.red.withAlpha(200),
            ),
          ),
      ],
    );
  }
}
