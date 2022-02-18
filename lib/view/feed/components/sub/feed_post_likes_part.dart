import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesostagram/view/comments/screens/comments_screen.dart';

import '../../../../deta_models/post.dart';
import '../../../../deta_models/user.dart';
import '../../../../style.dart';

class FeedPostLikesPart extends StatelessWidget {
  final Post post;
  final User postUser;

  const FeedPostLikesPart({required this.post, required this.postUser});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: null,
                  icon: FaIcon(FontAwesomeIcons.solidHeart)
              ),
              IconButton(
                  onPressed: () => _openCommentScreen(context, post, postUser),
                  icon: FaIcon(FontAwesomeIcons.comment)
              ),
            ],
          ),

          Text("0 いいね", style: numberOfLikesTextStyle,),
        ],
      ),
    );
  }

  _openCommentScreen(BuildContext context, Post post, User postUser) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CommentsScreen(post: post, postUser: postUser)
    ));
  }
}
