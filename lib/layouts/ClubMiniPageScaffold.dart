import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class ClubMiniPageScaffold extends StatelessWidget {
  final List<Widget> children;
  final Alignment? alignment;
  final MainAxisAlignment? mainAxisAlignment;
  final double? padding;
  final double? maxWidth;

  const ClubMiniPageScaffold({
    Key? key,
    required this.children,
    this.alignment,
    this.padding,
    this.maxWidth,
    this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle().background,
      body: Stack(
        children: [
          // Фоновая картинка
          Positioned.fill(
            child: Image.asset(
              'assets/img/background.png',
              // Убедитесь что добавили картинку в папку assets
              fit: BoxFit.cover,
              width: 196,
            ),
          ),

          /*
          Positioned.fill(
            child: Container(color: AppStyle().background.withAlpha(150)),
          ),
*/
          // Контент страницы
          Align(
            alignment: alignment ?? Alignment.center,
            child: Container(
              padding: EdgeInsetsGeometry.all(AppStyle().paddingScreen),
              constraints: BoxConstraints(maxWidth: maxWidth ?? 600),
              child: Column(
                mainAxisAlignment:
                mainAxisAlignment ?? MainAxisAlignment.center,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClubMiniPageStackVeticalScaffold extends StatelessWidget {
  final List<Widget> childrenTop;
  final List<Widget> childrenBottom;
  final Alignment? alignment;
  final MainAxisAlignment? mainAxisAlignment;
  final double? padding;
  final double? paddingTop;
  final String? background;

  const ClubMiniPageStackVeticalScaffold({
    Key? key,
    required this.childrenTop,
    required this.childrenBottom,
    this.alignment,
    this.padding,
    this.paddingTop,
    this.mainAxisAlignment,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle().background,
      body: Stack(
        children: [
          // Фоновая картинка
          Positioned.fill(
            child: Image.asset(
              background ?? 'assets/img/background.png',
              // Убедитесь что добавили картинку в папку assets
              fit: BoxFit.cover,
              width: 196,
            ),
          ),

          /*
          Positioned.fill(
            child: Container(color: AppStyle().background.withAlpha(150)),
          ),
*/
          // Контент страницы
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsetsGeometry.all(
                paddingTop ?? AppStyle().paddingScreen,
              ),
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: childrenTop,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsetsGeometry.all(AppStyle().paddingScreen),
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                mainAxisAlignment ?? MainAxisAlignment.center,
                children: childrenBottom,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClubScrollScaffold extends StatelessWidget {
  final List<Widget> children;
  final Alignment? alignment;
  final MainAxisAlignment? mainAxisAlignment;
  final double? padding;
  final String? background;

  const ClubScrollScaffold({
    Key? key,
    required this.children,
    this.alignment,
    this.padding,
    this.mainAxisAlignment,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(0),
        child: Container(
          padding: EdgeInsetsGeometry.all(padding ?? 0),
          //constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            children: children,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
