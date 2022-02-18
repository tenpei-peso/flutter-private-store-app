import 'package:flutter/material.dart';
import 'package:pesostagram/view/comments/components/comment_display_part.dart';
import 'package:pesostagram/view/comments/components/comment_input_part.dart';

import '../../../deta_models/post.dart';
import '../../../deta_models/user.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;
  final User postUser;

  const CommentsScreen({required this.post, required this.postUser});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("コメント"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CommentDisplayPart(
              postUserPhotoUrl: postUser.photoUrl,
              name: postUser.inAppUserName,
              text: post.caption,
              postDateTime: post.postDateTime,
            ),
            // TODO コメント
            CommentInputPart(post: post,)
          ],
        ),
      ),
    );
  }
}
