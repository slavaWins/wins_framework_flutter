import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class ButtonCircleIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? colorIcon;

  const ButtonCircleIcon({
    Key? key,
    required this.icon,
    this.size = 68,
    this.onPressed,
    this.color,
    this.colorIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const CircleBorder(),
      padding: EdgeInsets.all(size * 0.16),
      minWidth: size,
      height: size,
      color: color ?? AppStyle().primary,
      child: Icon(
        icon,
        color: colorIcon ?? Colors.black,
        size: size * 0.45,
      ),
      onPressed: onPressed ?? () {},
    );
  }
}