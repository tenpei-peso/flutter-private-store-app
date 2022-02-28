import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/common/components/user_card.dart';
import 'package:pesostagram/view/common/dailog/confirm_dialog.dart';
import 'package:pesostagram/view/feed/components/screens/feed_post_edit_screen.dart';
import 'package:pesostagram/view/profile/screens/profile_screen.dart';
import 'package:pesostagram/view_models/feed_view_model.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';


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
        onTap: () => _openProfile(context, postUser), //ここでプロフィール開く
        trailing: PopupMenuButton(
          icon: Icon(Icons.more_vert),
          onSelected: (PostMenu value) => _onPopupMenuSelected(context, value),
          itemBuilder: (context) {
            if(postUser.userId == currentUser.userId) {
              return [
                PopupMenuItem(
                    value: PostMenu.EDIT,
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('編集'),
                    ),
                ),
                PopupMenuItem(
                  value: PostMenu.DELETE,
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('削除'),
                  ),
                ),
                PopupMenuItem(
                  value: PostMenu.SHARE,
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('シェア'),
                  ),
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
      break;
      case PostMenu.SHARE:
        Share.share(post.imageUrl, subject: post.caption);
        break;
      case PostMenu.DELETE:
        showConfirmDialog(
            context: context,
            title: "投稿の削除",
            content: "投稿を削除してもよろしいですか？",
            onConfirmed: (isConfirmed) {
              if(isConfirmed) _deletePost(context, post);
            }
        );
    } //switch
  }

  void _deletePost(BuildContext context, Post post) async {
    final feedViewModel = context.read<FeedViewModel>();
    await feedViewModel.deletePost(post, feedMode); //feedMode渡す理由は、プロフからも削除できるから
  }

  void _openProfile(BuildContext context, User postUser) async {
    final feedViewModel = context.read<FeedViewModel>();
    //押した投稿のIDが自分の投稿だとMYSELF渡してそれ以外ならOTHER
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ProfileScreen(
            profileMode: (postUser.userId == feedViewModel.currentUser.userId)
            ? ProfileMode.MYSELF
            : ProfileMode.OTHER,
            selectedUser: postUser,
        )
    ));
  }
}
