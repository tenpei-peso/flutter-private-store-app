import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/feed/components/sub/image_from_url.dart';
import 'package:pesostagram/view/post/components/post_caption_input_text_field.dart';
import 'package:pesostagram/view/post/screens/enlarge_image_screen.dart';
import 'package:pesostagram/view_models/post_view_model.dart';
import 'package:provider/src/provider.dart';

import '../../../deta_models/post.dart';
import 'hero_image.dart';

class PostCaptionPart extends StatelessWidget {
  final PostCaptionOpenMode from;
  final Post? post;

  const PostCaptionPart({required this.from, this.post});

  @override
  Widget build(BuildContext context) {

    if (from == PostCaptionOpenMode.FROM_POST) {
      final postViewModel = context.read<PostViewModel>();
      final image = (postViewModel.imageFile != null) ? Image.file(postViewModel.imageFile!) : Image.asset("assets/images/no_image.png");

      return ListTile(
        leading: HeroImage(
          image: image,
          onTap: () => _displayLargeImage(context, image),
        ),
        title: PostCaptionInputTextField(),
      );
    } else {
      return Column(
        children: [
          ImageFromUrl(
            imageUrl: post?.imageUrl,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PostCaptionInputTextField(
              caption: post?.caption,
              from: from,
            ),
          ),
        ],
      );
    }
  }

  _displayLargeImage(BuildContext context, Image image) {
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => EnlargeImageScreen(image: image)
      )
    );
  }
}
