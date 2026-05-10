import 'package:flutter/material.dart';
import 'package:wins_framework_flutter/components/WinButton.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class CupertinoDrawerMenu extends StatelessWidget {
  final Widget children;

  const CupertinoDrawerMenu({super.key, required this.children});

  static void OpenMenu(BuildContext _context, Widget children) {
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

  const CupertinoModalWidget({
    super.key,
    required this.children,
    this.title,
    this.backgroundColor,
  });

  static void OpenMenu(BuildContext context, Widget children, {String? title, Color? backgroundColor}) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(100),
      builder: (context) =>
          CupertinoModalWidget(
            backgroundColor: backgroundColor,
            children: children,
            title: title,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 460,
          maxHeight: MediaQuery
              .of(context)
              .size
              .height * 0.9,
        ),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppStyle().background,
          borderRadius: BorderRadius.circular(12),
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

          WinButtonWidget(child: Icon(Icons.clear), onPressed: ()=>{
            Navigator.of(context).pop()
          },),


        ],
      ),
    );
  }
}