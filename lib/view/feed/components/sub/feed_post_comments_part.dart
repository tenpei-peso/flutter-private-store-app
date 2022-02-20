import 'package:flutter/material.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/utils/functions.dart';
import 'package:pesostagram/view/common/components/comment_rich_text.dart';
import 'package:provider/provider.dart';

import '../../../../deta_models/comments.dart';
import '../../../../deta_models/post.dart';
import '../../../../deta_models/user.dart';
import '../../../../view_models/feed_view_model.dart';
import '../../../comments/screens/comments_screen.dart';

class FeedPostCommentsPart extends StatelessWidget {
  final Post post;
  final User postUser;

  const FeedPostCommentsPart({required this.post, required this.postUser});

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommentRichText(name: postUser.inAppUserName, text: post.caption),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: InkWell(
              onTap: () => _openCommentScreen(context, post, postUser),
              child: FutureBuilder(
                  future: feedViewModel.getComments(post.postId),
                  builder: (context, AsyncSnapshot<List<Comment>> snapshot) {
                    if(snapshot.hasData && snapshot != null) {
                      final comments = snapshot.data!;
                      return Text(
                        "${comments.length.toString()} コメント",
                        style: numberOfCommentsTextStyle,
                      );
                    } else {
                      return Container();
                    }
                  },
            ),
          ),
          ),
          Text(createTimeAgoString(post.postDateTime), style: TimeTextStyle,)
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
