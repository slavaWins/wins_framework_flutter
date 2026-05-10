import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class PhotoViewerModal extends StatefulWidget {
  final String url;

  const PhotoViewerModal({Key? key, required this.url}) : super(key: key);

  static void OpenPohotoFullscreen(String url, BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withAlpha(100),
      builder: (context) => PhotoViewerModal(url: url),
    );
  }

  @override
  State<PhotoViewerModal> createState() => _PhotoViewerModalState();
}

class _PhotoViewerModalState extends State<PhotoViewerModal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child:  Container(
        padding: EdgeInsetsGeometry.all(AppStyle().paddingCard),
        child: CachedNetworkImage(
          imageUrl: widget.url,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Center(child: Container(child: CircularProgressIndicator())),
        ),
      ),
      ),
    );
  }
}
