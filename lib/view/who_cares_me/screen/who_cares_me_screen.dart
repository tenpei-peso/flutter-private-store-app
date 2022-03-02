import 'package:flutter/material.dart';
import 'package:pesostagram/deta_models/user.dart';
import 'package:pesostagram/view/common/components/user_card.dart';
import 'package:pesostagram/view/profile/screens/profile_screen.dart';
import 'package:pesostagram/view_models/who_cares_me_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';

class WhoCaresMeScreen extends StatelessWidget {
  final WhoCaresMeMode mode;
  final String id;

  const WhoCaresMeScreen({required this.mode, required this.id});

  @override
  Widget build(BuildContext context) {
    //画面開いたらデータとってくる
    final whoCaresMeViewModel = context.read<WhoCaresMeViewModel>();
    Future(() => whoCaresMeViewModel.getCaresUserData(id, mode));

    return Scaffold(
      appBar: AppBar(
        title: Text(_titleText(context, mode)),
      ),

      body: Consumer<WhoCaresMeViewModel>(
          builder: (context, model, child) {
            return model.careUserData.isEmpty
                ? Container()
                : ListView.builder(
                    itemCount: model.careUserData.length,
                    itemBuilder: (context, int index) {
                      final user = model.careUserData[index];
                      return UserCard(
                          photoUrl: user.photoUrl,
                          title: user.inAppUserName,
                          subTitle: user.bio,
                          onTap: () => _openProfileScreen(context, user),
                      );
                    }
                );
          }
      ),
    );
  }

  //AppBarのタイトルテキスト
  String _titleText(BuildContext context, WhoCaresMeMode mode) {
    var titleText = "";
    switch (mode) {
      case WhoCaresMeMode.LIKE:
        titleText = "いいね";
        break;
      case WhoCaresMeMode.FOLLOWINGS:
        titleText = "フォロー";
        break;
      case WhoCaresMeMode.FOLLOWED:
        titleText = "フォロワー";
        break;
    }
    return titleText;
  }

  _openProfileScreen(BuildContext context, User user) {
    final whoCaresMeViewModel = context.read<WhoCaresMeViewModel>();
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ProfileScreen(
            profileMode: (user.userId == whoCaresMeViewModel.currentUser.userId)
              ? ProfileMode.MYSELF
              : ProfileMode.OTHER,
            selectedUser: user,
        )
    ));

  }

}
