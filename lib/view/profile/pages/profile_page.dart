import 'package:flutter/material.dart';
import 'package:pesostagram/deta_models/user.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/profile/components/profile_detail_part.dart';
import 'package:pesostagram/view/profile/components/profile_posts_grid_part.dart';
import 'package:pesostagram/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../components/profile_setting_part.dart';

class ProfilePage extends StatelessWidget {
  //bottomButtonからのみModeだけ渡し、それ以外はselectedUserを渡す
  final ProfileMode profileMode;
  final User? selectedUser;

  const ProfilePage({required this.profileMode, this.selectedUser});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    //modeから表示するユーザー判別 profileUser決める
    profileViewModel.setProfileUser(profileMode, selectedUser);
    //表示する投稿とってくる
    Future(() => profileViewModel.getPost());

    return Scaffold(
      body: Consumer<ProfileViewModel>(builder: (context, model, child) {
        final profileUser = model.profileUser;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: Colors.white30,
              actions: [
                ProfileSettingPart(profileMode: profileMode,)
              ],
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: ProfileDetailPart(
                  profileMode: profileMode,
                ),
              ),
            ),

            ProfilePostsGridPart(posts: model.posts),
          ],
        );
      }),
    );
  }
}
