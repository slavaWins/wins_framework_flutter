import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../modals/PhotoViewerModal.dart';

class PhotoCollageElement extends StatelessWidget {
  final List<String>? urls;
  final double spacing;
  final double borderRadius;
  final double? height;

  const PhotoCollageElement({
    Key? key,
    this.urls,
    this.spacing = 4.0,
    this.borderRadius = 8.0,
    this.height = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (urls == null || urls!.isEmpty) {
      return _buildPlaceholder();
    }

    return urls!.length == 1
        ? _buildSingleImage(urls!.first, context)
        : _buildImageGrid(urls!);
  }

  Widget _buildSingleImage(String url, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch ,
      
      children: [
        GestureDetector(
          onTap: (){

            PhotoViewerModal.OpenPohotoFullscreen(url, context);

          },
          child:

        ClipRRect(
          //borderRadius: BorderRadius.circular(borderRadius),
          child: CachedNetworkImage(
            height: height,
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Center(child: Container(height: height,child: CircularProgressIndicator())),
            errorWidget: (context, url, error) => _buildPlaceholder(size: height),
          ),
        ),
        ),
      ],
    );
  }

  Widget _buildImageGrid(List<String> urls) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = urls.length == 2
            ? 2
            : urls.length <= 4
            ? 2
            : 3;
        final itemSize =
            (constraints.maxWidth - (crossAxisCount - 1) * spacing) /
            crossAxisCount;

        return GridView.count(

          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          children: urls.map((url) => _buildGridItem(url, itemSize, context)).toList(),
        );
      },
    );
  }

  Widget _buildGridItem(String url, double size, BuildContext context) {
    return GestureDetector(
        onTap: (){

          PhotoViewerModal.OpenPohotoFullscreen(url, context);

        },
        child: ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => _buildPlaceholder(size: size),
      ),
      ),
    );
  }

  Widget _buildPlaceholder({double? size}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        //width: size,
        height: size,
        color: Colors.grey[200],
        child: Icon(Icons.image, color: Colors.grey[400]),
      ),
    );
  }
}
