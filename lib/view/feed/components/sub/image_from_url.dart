import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;

  const ImageFromUrl({this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return (imageUrl == null)
        ? Icon(Icons.broken_image)
          // CachedNetWorkは一度ダウンロードすると次から通信しなくて良くなる
        : CachedNetworkImage(
            imageUrl: imageUrl!,
            width: (width != null) ? width : null,
            height: (height != null) ? height : null,
            placeholder: (context, url) => CircularProgressIndicator(), //ダウンロード中
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          );
  }
}
