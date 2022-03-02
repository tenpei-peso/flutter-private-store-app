import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/comments/screens/comments_screen.dart';
import 'package:pesostagram/view/who_cares_me/screen/who_cares_me_screen.dart';
import 'package:pesostagram/view_models/feed_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../deta_models/like.dart';
import '../../../../deta_models/post.dart';
import '../../../../deta_models/user.dart';
import '../../../../style.dart';

class FeedPostLikesPart extends StatelessWidget {
  final Post post;
  final User postUser;

  const FeedPostLikesPart({required this.post, required this.postUser});


  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: FutureBuilder(
        future: feedViewModel.getLikeResult(post.postId),
        builder: (context, AsyncSnapshot<LikeResult> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final likeResult = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    likeResult.isLikedToThisPost
                    ? IconButton(
                        onPressed: () => unLikeIt(context),
                        icon: Icon(Icons.favorite, color: Colors.red,)
                      )
                    : IconButton(
                        onPressed: () => likeIt(context),
                        icon: Icon(Icons.favorite_border)
                      ),

                    IconButton(
                        onPressed: () => _openCommentScreen(context, post, postUser),
                        icon: Icon(Icons.comment)
                    ),
                  ],
                ),

                GestureDetector(
                    onTap: () => _checkLikeUsers(context),
                    child: Text("${likeResult.likes.length.toString()} いいね", style: numberOfLikesTextStyle,)
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  //コメント数の所押したらcommentScreen開く
  _openCommentScreen(BuildContext context, Post post, User postUser) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CommentsScreen(post: post, postUser: postUser)
    ));
  }
  //ハート押すとDBに追加
  void likeIt(BuildContext context) async {
    final feedViewModel = context.read<FeedViewModel>();
    await feedViewModel.likeIt(post);
  }

  void unLikeIt(BuildContext context) async {
    final feedViewModel = context.read<FeedViewModel>();
    await feedViewModel.unLikIt(post);
  }

  _checkLikeUsers(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => WhoCaresMeScreen(mode: WhoCaresMeMode.LIKE, id: post.postId,)
    ));
  }
}
