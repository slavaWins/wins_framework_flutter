import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Future<void> main() async {

  runApp(const MyApp());
}

//class MyApp extends StatefulWidget {  const MyApp({super.key});

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeNotification = ThemeNotification();

  final presenceManager = PresenceManager();

  void OnGlobalStateUpdate() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    presenceManager.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    presenceManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeNotification.onChange = (x) {
      OnGlobalStateUpdate();
    };

    AppStyle().ApplyStyleSystem();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',

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
          onPrimary: AppStyle().black,  // цвет текста на primary
          secondary: AppStyle().primary,
          onSecondary: AppStyle().black,
          surface: AppStyle().background,
          onSurface: AppStyle().black,  // 👈 ЭТО ОТВЕЧАЕТ ЗА ЦВЕТ ТЕКСТА ПО УМОЛЧАНИЮ!
          error: Colors.red,
          onError: Colors.white,
        ),
        primaryColor: AppStyle().primary,
        focusColor:  AppStyle().primary,
        fontFamily: "Main",
        highlightColor:  AppStyle().primary,

      ),

      home: LogoPage(),
    );
  }
}
