import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  final String? imageUrl;

  const ImageFromUrl({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          child: (imageUrl != null) ? Image.network(imageUrl!) : Icon(Icons.broken_image),
        )
    );
  }
}
