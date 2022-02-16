import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/common/components/user_card.dart';
import 'package:pesostagram/view/common/dailog/confirm_dialog.dart';
import 'package:pesostagram/view/post/components/post_caption_part.dart';
import 'package:provider/provider.dart';

import '../../../../deta_models/post.dart';
import '../../../../deta_models/user.dart';
import '../../../../view_models/feed_view_model.dart';

class FeedPostEditScreen extends StatelessWidget {
  final Post post;
  final User postUser;
  final FeedMode feedMode;

  const FeedPostEditScreen(
      {required this.post, required this.postUser, required this.feedMode});

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: model.isProcessing
            ? Container()
            : IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),

            title: model.isProcessing
            ? Text("処理中です")
            : Text("情報の編集"),

            actions: [
              model.isProcessing
              ? Container()
              : IconButton(
                onPressed: () => showConfirmDialog(
                    context: context,
                    title: "投稿編集",
                    content: "編集してもよろしいですか？",
                    onConfirmed: (isConfirmed) {
                      if (isConfirmed) {
                        _updatePost(context);
                      }
                    }),
                icon: Icon(Icons.done),
              )

            ],
          ),

          body: model.isProcessing
          ? Center(child: CircularProgressIndicator(),)
          : SingleChildScrollView(
            child: Column(
              children: [
                UserCard(
                  photoUrl: postUser.photoUrl,
                  title: postUser.inAppUserName,
                  subTitle: post.locationString,
                  onTap: null,
                ),
                PostCaptionPart(
                  from: PostCaptionOpenMode.FROM_FEED,
                  post: post,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _updatePost(BuildContext context) async {
    final feedViewModel = context.read<FeedViewModel>();
    await feedViewModel.updatePost(post, feedMode);
    Navigator.pop(context);
  }
}
