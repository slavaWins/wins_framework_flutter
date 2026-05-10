import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class ScaffoldWithSvgBackground extends StatelessWidget {
  final List<Widget> children;
  final Alignment? alignment;
  final double? padding;
  final String? src;

  const ScaffoldWithSvgBackground({
    Key? key,
    required this.children,
    this.alignment,
    this.padding,
    this.src,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle().background,
      body: Stack(
        children: [
          // Фоновая картинка
          Positioned.fill(

            child: SvgPicture.asset(
              src ?? 'assets/img/background-x.svg',

              colorFilter: ColorFilter.mode(
                AppStyle().background,
                BlendMode.screen,

              ),
              fit: BoxFit.cover,
            ),
          ),

          // Затемнение фона для лучшей читаемости
          Positioned.fill(
            child: Container(color: AppStyle().background.withAlpha(150)),
          ),

          // Контент страницы
          Align(
            alignment: alignment ?? Alignment.center,
            child: Container(
              padding: EdgeInsetsGeometry.all(AppStyle().paddingCard),
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
