import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  final String? imageUrl;

  const ImageFromUrl({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          child: (imageUrl == null)
              ? Icon(Icons.broken_image)
                // CachedNetWorkは一度ダウンロードすると次から通信しなくて良くなる
              : CachedNetworkImage(
                  imageUrl: imageUrl!,
                  placeholder: (context, url) => CircularProgressIndicator(), //ダウンロード中
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                )
        )
    );
  }
}
