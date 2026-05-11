import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class CardContainer extends StatelessWidget {
  final List<Widget> children;
  final double? rad;
  final double? padding;
  final double? margin;
  final Color? color;
  final double? spacing;
  final CrossAxisAlignment? crossAxisAlignment;

  const CardContainer({
    Key? key,
    required this.children,
    this.rad,
    this.padding,
    this.margin,
    this.color,
    this.crossAxisAlignment,
    this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(padding ?? AppStyle().paddingCard),
      margin: EdgeInsetsGeometry.all(margin ?? 0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color ?? AppStyle().card,
        borderRadius: BorderRadius.circular(rad ?? 20),
        /*
        boxShadow: [
          BoxShadow(
            color: Colors.systemGrey.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
        */
      ),
      child: Column(mainAxisSize: MainAxisSize.min,
          spacing: spacing  ?? 0,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: children),
    );
  }
}


