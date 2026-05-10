import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class BadgeTabBar extends StatelessWidget {
  final List<BadgeTabItem> tabs;
  final ValueChanged<int>? onTap;

  const BadgeTabBar({Key? key, required this.tabs, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: 148,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final tab = tabs[index];
          return _BadgeTabItemWidget(
            text: tab.text,
            amount: tab.amount,
            isSelected: tab.isSelected,
            onTap: () => onTap?.call(index),
          );
        }),
      ),
    );
  }
}

class BadgeTabItem {
  final String text;
  final int amount;
  final bool isSelected;
  final VoidCallback? onTap;

  BadgeTabItem({
    required this.text,
    required this.amount,
    required this.isSelected,
    this.onTap,
  });
}

class _BadgeTabItemWidget extends StatelessWidget {
  final String text;
  final int amount;
  final bool isSelected;
  final VoidCallback? onTap;

  const _BadgeTabItemWidget({
    Key? key,
    required this.text,
    required this.amount,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentColor = isSelected ? AppStyle().primary : AppStyle().black54;

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text, style: TextStyle(color: currentColor, fontSize: 16, fontWeight: FontWeight.w500)),
                if (amount > 0) ...[
                  const SizedBox(width: 4),
                  _buildBadge(amount, AppStyle().primary),
                ],
              ],
            ),
            const SizedBox(height: 4), // Отступ между текстом и линией




          ],
        ),
      ),
    );
  }

  Widget _buildBadge(int amount, Color color) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          amount > 99 ? '99+' : amount.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 22 * 0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
