import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';


class WinNavigationShort extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onPop;
  final bool? isPopSupport;
  final String? title;
  final Widget? trilingCustom;
  final double? padding;
  final IconData? iconPop;
  final Color? colorText;

  const WinNavigationShort({
    Key? key,
    required this.isPopSupport,
    this.onPressed,
    this.padding,
    this.trilingCustom,
    this.colorText,
    this.title,
    this.iconPop,
    this.onPop,
  }) : super(key: key);

  // assets/img/eventBlurBackground.png
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(padding ?? 16),
      child: Row(
        children: [
          ElevatedButton(

            child: Icon(iconPop ?? Icons.keyboard_arrow_left),
            onPressed: () {

              if(isPopSupport==false){
                return;
              }
              if(onPop!=null) {
                onPop!();
                return;
              }
              Navigator.of(context).pop();

            }
          ),
          Spacer(),

          if (title != null)...[
            Text(title!, style: AppStyle().h3(color: colorText)),
            Spacer(),
          ],

          if (trilingCustom == null)SizedBox(width: 55,),

          if (trilingCustom != null) ...[trilingCustom!],
        ],
      ),
    );
  }
}
