import 'package:flutter/material.dart';
import 'package:pesostagram/view/post/components/hero_image.dart';

class EnlargeImageScreen extends StatelessWidget {
  final Image image;

  const EnlargeImageScreen({required this.image});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: HeroImage(
          image: image,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
