import 'package:flutter/material.dart';
import 'package:wins_framework_flutter/components/WinButton.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class CupertinoDrawerMenu extends StatelessWidget {
  final Widget children;

  const CupertinoDrawerMenu({super.key, required this.children});

  static void OpenMenu(BuildContext _context, Widget children, double? maxWidth) {
    showDialog(
      context: _context,
      barrierColor: Colors.black.withAlpha(95), // Полупрозрачный фон

      builder: (context) => CupertinoDrawerMenu(children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.topLeft,

      child: Container(
        decoration: BoxDecoration(
          color: AppStyle().background, // Полностью прозрачный
          borderRadius: BorderRadius.circular(0),
        ),
        width: 320,
        //padding:  EdgeInsets.all(AppStyle().paddingCard),
        child: children,
      ),
    );
  }
}


class CupertinoModalWidget extends StatelessWidget {
  final Widget children;
  final String? title;
  final Color? backgroundColor;
  final double? maxWidth;
  final double? maxHeight;

  const CupertinoModalWidget({
    super.key,
    required this.children,
    this.title,
    this.backgroundColor,
    this.maxWidth,
    this.maxHeight,
  });

  static void OpenMenu(BuildContext context, Widget children, {String? title, Color? backgroundColor, double? maxWidth, double? maxHeight}) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(100),
      builder: (context) =>
          CupertinoModalWidget(
            backgroundColor: backgroundColor,
            children: children,
            title: title,
              maxWidth:maxWidth,
            maxHeight:maxHeight,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 0,
          maxWidth: maxWidth ?? 460,
          maxHeight:maxHeight ?? MediaQuery
              .of(context)
              .size
              .height * 0.9,
        ),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:  backgroundColor ?? AppStyle().background,
          borderRadius: BorderRadius.circular(AppStyle().radiusCard),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Заголовок с крестиком
            if (title != null) BuildHeaderDesign(context, title!),
            // Контент

            Flexible(
              child: children,
            ),
          ],
        ),
      ),
    );
  }


  static Widget BuildHeaderDesign(BuildContext context, String titleText) {
    return Container(
      padding: EdgeInsets.all(AppStyle().paddingCard),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withAlpha(60),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              titleText,
              style: TextStyle(
                fontSize: 18,
                color: AppStyle().black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          WinButtonWidget(
            isBordered: false,
            child: Icon(Icons.clear), onPressed: ()=>{
            Navigator.of(context).pop()
          },),


        ],
      ),
    );
  }
}