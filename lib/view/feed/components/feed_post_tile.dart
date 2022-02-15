import 'package:flutter/material.dart';
import 'package:pesostagram/view/feed/components/sub/feed_post_comments_part.dart';
import 'package:pesostagram/view/feed/components/sub/feed_post_header_part.dart';
import 'package:pesostagram/view/feed/components/sub/feed_post_likes_part.dart';
import 'package:pesostagram/view/feed/components/sub/image_from_url.dart';
import 'package:pesostagram/view_models/feed_view_model.dart';
import 'package:provider/provider.dart';

import '../../../deta_models/post.dart';
import '../../../deta_models/user.dart';
import '../../../utils/constants.dart';

class FeedPostTile extends StatelessWidget {
  final FeedMode feedMode;
  final Post post;

  const FeedPostTile({required this.feedMode, required this.post});

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),

      //headerのアイコンをUser情報からとってきたい
      //ここでFeedSubPageのようにinitState的な感じでページロード時にViewModelからUser情報とってくるようにすると
      //FeedSubPageのconsumer下なので無限ループに陥るのでFutureBuilderを使う。
      child: FutureBuilder(
        future: feedViewModel.getPostUserInfo(post.userId),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            final postUser = snapshot.data!;
            final currentUser = feedViewModel.currentUser;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FeedPostHeaderPart(),
                ImageFromUrl(imageUrl: post.imageUrl,),
                FeedPostLikesPart(),
                FeedPostCommentsPart(),
              ],
            );
          } else {
            return Container();
          }
        },
      ),

    );
  }
}
