import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class MyAppWinFreamwork extends StatefulWidget {
  final String title;
  final Widget  homeBuilder;
  final Function()? onInit;
  final Function()? onDispose;

  const MyAppWinFreamwork({
    Key? key,
    required this.title,
    required this.homeBuilder,
    this.onInit,
    this.onDispose,
  }) : super(key: key);

  @override
  State<MyAppWinFreamwork> createState() => _MyAppWinFreamworkState();
}

class _MyAppWinFreamworkState extends State<MyAppWinFreamwork> {
  final _themeNotification = ThemeNotification();

  void OnGlobalStateUpdate() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeNotification.onChange = (x) {
      OnGlobalStateUpdate();
    };

    AppStyle().ApplyStyleSystem();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,

      builder: (context, child) {
        // Этот builder не сбрасывается при навигации
        return ToastificationWrapper(
          config: ToastificationConfig(
            alignment: AlignmentGeometry.topCenter,
            animationDuration: Duration(milliseconds: 200),
          ),
          child: child!,
        );
      },

      theme: ThemeData(
        brightness: AppStyle().themeNameFlutter,

        //  applyThemeToAll: true,
        textTheme: TextTheme(
          titleSmall: TextStyle(
            fontSize: 16,
            color: AppStyle().black,
            fontWeight: FontWeight.w400,
            fontFamily: "Main",
            height: 1.20,
          ),

          titleLarge: TextStyle(
            fontSize: 16,
            color: AppStyle().black,
            fontFamily: "Main",
            height: 1.20,
          ),

          headlineMedium: TextStyle(
            fontSize: 24,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
            color: AppStyle().black,
            fontFamily: "Main",
            height: 1.20,
          ),

          titleMedium: TextStyle(
            fontSize: 16,
            color: AppStyle().black,
            fontFamily: "Main",
            height: 1.20,
          ),
        ),

        scaffoldBackgroundColor: AppStyle().background,
        colorScheme: ColorScheme(
          brightness: AppStyle().themeNameFlutter,
          primary: AppStyle().black,
          onPrimary: AppStyle().black,
          // цвет текста на primary
          secondary: AppStyle().primary,
          onSecondary: AppStyle().black,
          surface: AppStyle().background,
          onSurface: AppStyle().black,
          // 👈 ЭТО ОТВЕЧАЕТ ЗА ЦВЕТ ТЕКСТА ПО УМОЛЧАНИЮ!
          error: Colors.red,
          onError: Colors.white,
        ),
        primaryColor: AppStyle().primary,
        focusColor: AppStyle().primary,
        fontFamily: "Main",
        highlightColor: AppStyle().primary,
      ),

      home: widget.homeBuilder,
    );
  }
}
