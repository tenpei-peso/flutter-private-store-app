import 'package:flutter/material.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/view/common/components/circle_photo.dart';
import 'package:pesostagram/view_models/comments_view_model.dart';
import 'package:provider/provider.dart';

import '../../../deta_models/post.dart';

class CommentInputPart extends StatefulWidget {
  final Post post;

  const CommentInputPart({required this.post});

  @override
  _CommentInputPartState createState() => _CommentInputPartState();
}

class _CommentInputPartState extends State<CommentInputPart> {
  final _commentInputController = TextEditingController();
  bool isCommentEnable = false;


  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final commentViewModel = context.watch<CommentsViewModel>();
    final commenter = commentViewModel.currentUser;

    return Card(
      color: cardColor,
      child: ListTile(
        leading: CirclePhoto(
          photoUrl: commenter.photoUrl,
          isImageFromFile: false,
        ),
        title: TextField(
          controller: _commentInputController,
          style: commentInputTextStyle,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: "コメントを追加",
          ),
          onChanged: (value) {
            commentChanged(value);
          },
        ),
        trailing: TextButton(
          child: Text("投稿", style: TextStyle(color: isCommentEnable ? Colors.blue : Colors.grey),),
          onPressed: isCommentEnable
          ? () => _postComment(context, widget.post)
          : null,
        ),
      ),
    );
  }

  void commentChanged(value) {
    final commentsViewModel = context.read<CommentsViewModel>();
    commentsViewModel.comment = value;

    setState(() {
      if(_commentInputController.text.length > 0) {
        isCommentEnable = true;
      } else {
        isCommentEnable = false;
      }
    });
  }

  _postComment(BuildContext context, Post post) async {
    final commentsViewModel = context.read<CommentsViewModel>();
    await commentsViewModel.postComment(post);
    _commentInputController.clear();
  }
}
