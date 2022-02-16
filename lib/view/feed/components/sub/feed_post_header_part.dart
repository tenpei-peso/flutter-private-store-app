import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/common/components/user_card.dart';
import 'package:pesostagram/view/feed/components/screens/feed_post_edit_screen.dart';

import '../../../../deta_models/post.dart';
import '../../../../deta_models/user.dart';

class FeedPostHeaderPart extends StatelessWidget {
  final User postUser;
  final Post post;
  final User currentUser;
  final FeedMode feedMode;

  const FeedPostHeaderPart({required this.postUser, required this.post, required this.currentUser, required this.feedMode});

  @override
  Widget build(BuildContext context) {
    return UserCard(
        photoUrl: postUser.photoUrl,
        title: postUser.inAppUserName,
        subTitle: post.locationString,
        onTap: null, //TODO
        trailing: PopupMenuButton(
          icon: Icon(Icons.more_vert),
          onSelected: (PostMenu value) => _onPopupMenuSelected(context, value),
          itemBuilder: (context) {
            if(postUser.userId == currentUser.userId) {
              return [
                PopupMenuItem(
                    value: PostMenu.EDIT,
                    child: Text("編集"),
                ),
                PopupMenuItem(
                  value: PostMenu.DELETE,
                  child: Text("削除"),
                ),
                PopupMenuItem(
                  value: PostMenu.SHARE,
                  child: Text("シェア"),
                )
              ];
            } else {
              return [
                PopupMenuItem(
                  value: PostMenu.SHARE,
                  child: Text("シェア"),
                )
              ];
            }
          }, //itemBuilder
        ),
    );
  }

  _onPopupMenuSelected(BuildContext context, PostMenu selectedMenu) {
    switch(selectedMenu) {
      case PostMenu.EDIT:
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => FeedPostEditScreen(
                post: post,
                postUser: postUser,
                feedMode: feedMode
            )
        ));

    } //switch
  }
}
