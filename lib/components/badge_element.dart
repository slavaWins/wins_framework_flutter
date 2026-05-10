import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class BadgeElement extends StatelessWidget {
  final int amount;
  final Color colorBack;//= AppStyle().black87;

  const BadgeElement({
    Key? key,
    required this.amount,
    required this.colorBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return         Container(
      margin: EdgeInsets.only(left: 4),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorBack,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(amount.toString(),
        style: TextStyle(
            color: AppStyle().white,
            fontSize: 10,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}


