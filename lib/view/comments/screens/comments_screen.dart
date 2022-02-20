import 'package:flutter/material.dart';
import 'package:pesostagram/deta_models/comments.dart';
import 'package:pesostagram/view/comments/components/comment_display_part.dart';
import 'package:pesostagram/view/comments/components/comment_input_part.dart';
import 'package:pesostagram/view/common/dailog/confirm_dialog.dart';
import 'package:pesostagram/view_models/comments_view_model.dart';
import 'package:provider/provider.dart';

import '../../../deta_models/post.dart';
import '../../../deta_models/user.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;
  final User postUser;

  const CommentsScreen({required this.post, required this.postUser});

  @override
  Widget build(BuildContext context) {
    final commentsViewModel = context.read<CommentsViewModel>();
    Future(() => commentsViewModel.getComments(post.postId));

    return Scaffold(
      appBar: AppBar(
        title: Text("コメント"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //投稿表示部分
              CommentDisplayPart(
                postUserPhotoUrl: postUser.photoUrl,
                name: postUser.inAppUserName,
                text: post.caption,
                postDateTime: post.postDateTime,
              ),
              Divider(height: 10, color: Colors.black,),
              //コメント表示部分
              Consumer<CommentsViewModel>(
                  builder: (context, model, child) {
                    return LimitedBox(
                      maxHeight: 525,
                      child: ListView.builder(
                          itemCount: model.comments.length,
                          itemBuilder: (context, index) {
                            final comment = model.comments[index];
                            final commentUserId = comment.commentUserId;
                            return FutureBuilder(
                                future: model.getCommentUserInfo(commentUserId),
                                builder: (context, AsyncSnapshot<User> snapshot) {
                                  if (snapshot.hasData && snapshot.data != null) {
                                    final commentUser = snapshot.data!;
                                    return CommentDisplayPart(
                                        postUserPhotoUrl: commentUser.photoUrl,
                                        name: commentUser.inAppUserName,
                                        text: comment.comment,
                                        postDateTime: comment.commentDataTime,
                                        onLongPressed: () => showConfirmDialog(
                                            context: context,
                                            title: "コメントの削除",
                                            content: "削除しますか？",
                                            onConfirmed: (isConfirmed) {
                                              _deleteComment(context, comment);
                                            }
                                        ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                            );
                          }
                      ),
                    );
                  }
              ),

              //コメント入力部分
              CommentInputPart(post: post,)
            ],
          ),
        ),
      ),
    );
  }

  void _deleteComment(BuildContext context, Comment comment, ) async {
    final commentsViewModel = context.read<CommentsViewModel>();
    await commentsViewModel.deleteComment(post, comment);
  }
}
