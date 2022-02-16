import 'package:flutter/material.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/utils/functions.dart';
import 'package:pesostagram/view/common/components/comment_rich_text.dart';

import '../../../../deta_models/post.dart';
import '../../../../deta_models/user.dart';

class FeedPostCommentsPart extends StatelessWidget {
  final Post post;
  final User postUser;

  const FeedPostCommentsPart({required this.post, required this.postUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommentRichText(name: postUser.inAppUserName, text: post.caption),
          InkWell(
            onTap: null,
            child: Text("0 コメント", style: numberOfCommentsTextStyle,),
          ),
          Text(createTimeAgoString(post.postDateTime), style: TimeTextStyle,)
        ],
      ),
    );
  }
}
