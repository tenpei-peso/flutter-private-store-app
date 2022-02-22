import 'package:flutter/material.dart';
import 'package:pesostagram/deta_models/user.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../../style.dart';
import '../../../../view_models/profile_view_model.dart';

class ProfileBio extends StatelessWidget {
  final ProfileMode profileMode; //自分の投稿だとプロフ編集。他だとフォロー

  const ProfileBio({required this.profileMode});
  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    final postsLength = profileViewModel.posts.length;

    return Column(
      children: [
        //ユーザー名前
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            alignment: const Alignment(0, -1),
            child: Text(profileViewModel.profileUser.inAppUserName, style: profileRecodeScoreTextStyle,),
          ),
        ),

        //プロフ編集
        Container(
          height: 110,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO bio
              Text("バイオ"),
              SizedBox(height: 40.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                  width: double.infinity,
                  child: _button(context, profileViewModel.profileUser),
                ),
              )
            ],
          ),
        ),

        //ユーザーの投稿、フォロワーなど出すとこ
        Container(
          child: Row(
            children: [
              _userRecodeWidget(
                context: context,
                score: postsLength,
                title: "投稿",
              ),
              FutureBuilder(
                  future: profileViewModel.getNumberOfFollowers(),
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    return _userRecodeWidget(
                      context: context,
                      score: (snapshot.hasData ) ? snapshot.data! : 0,
                      title: "フォロワー",
                    );
                  }
              ),

              FutureBuilder(
                  future: profileViewModel.getNumberOfFollowings(),
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    return _userRecodeWidget(
                      context: context,
                      score: (snapshot.hasData ) ? snapshot.data! : 0,
                      title: "フォロー",
                    );
                  }
              ),
            ],
          ),
        )

      ],
    );
  }
  //何個も同じもの使うので別わけ
  _userRecodeWidget({required BuildContext context, required int score, required String title}) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(
            score.toString(),
            style: profileRecodeScoreTextStyle,
          ),
          Text(
            title,
            style: profileRecodeTitleTextStyle,
          )
        ],
      ),
    );
  }

  _button(BuildContext context, User profileUser) {
    return ElevatedButton(
      child: (profileMode == ProfileMode.MYSELF)
      ? Text("プロフィール編集")
      //TODO フォローしてる場合はフォロー解除
      : Text("フォロー"),
      onPressed: null,
      //スタイル
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        side: BorderSide(
          color: Colors.black, //枠線!
          width: 1, //枠線！
        ),
      ),
    );
  }


}
