import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  final Image image;
  final VoidCallback? onTap;

  const HeroImage({required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "postImage",
        child: Material(
          color: Colors.white38,
          child: InkWell(
            onTap: onTap,
            child: image,
          ),
        )
    );
  }
}
