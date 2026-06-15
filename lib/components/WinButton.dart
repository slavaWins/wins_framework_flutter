import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class WinButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final IconData? leading;
  final double? height;
  final bool? isLeft;
  final Color? customBackground;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final bool isBordered;

  const WinButton({
    super.key,
    this.onPressed,
    this.text,
    this.leading,
    this.height,
    this.isLeft,
    this.customBackground,
    this.radius = 32,
    this.isBordered = false, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          if (leading != null) Icon(leading, size: 26, color: AppStyle().black),

          if (text != null)
            Text(text!, style: AppStyle().body2(color: AppStyle().black)),
        ],
      ),
    );
  }
}

class WinButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final IconData? leading;
  final double? height;
  final bool? isLeft;
  final Color? customBackground;
  final double radius;
  final EdgeInsetsGeometry? padding;

  final bool isBordered;

  const WinButtonWidget({
    super.key,
    this.onPressed,
    required this.child,
    this.leading,
    this.height,
    this.isLeft,
    this.customBackground,
    this.radius = 32,
    this.isBordered = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: padding,
        side:  (isBordered) ?  BorderSide(color: AppStyle().black, width: 1) :   BorderSide.none,  // 👈 Убираем бордер
        backgroundColor: Colors.transparent,  // 👈 Прозрачный фон
        minimumSize: Size(0, 0),

      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          if (leading != null) Icon(leading, size: 26, color: AppStyle().black),

          child,
        ],
      ),
    );
  }
}
