import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/login/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../../../view_models/profile_view_model.dart';

class ProfileSettingPart extends StatelessWidget {
  final ProfileMode profileMode;

  const ProfileSettingPart({required this.profileMode});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(Icons.settings),
        onSelected: (ProfileSettingMenu value) => _onPopupMenuSelected(context, value),
        itemBuilder: (context) {
          if(profileMode == ProfileMode.MYSELF) {
            return [
              PopupMenuItem(
                value: ProfileSettingMenu.THEME_CHANGE,
                child: ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text('ダークテーマ'),
                ),
              ),
              PopupMenuItem(
                value: ProfileSettingMenu.SIGN_OUT,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('ログアウト'),
                ),
              ),
            ]; //return
          } else {
            return [
              PopupMenuItem(
                value: ProfileSettingMenu.THEME_CHANGE,
                child: ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text('ダークテーマ'),
                ),
              ),
            ];
          }
        },
    );
  }

  _onPopupMenuSelected(BuildContext context, ProfileSettingMenu value) {
    switch(value) {
      case ProfileSettingMenu.THEME_CHANGE:
        break;
      case ProfileSettingMenu.SIGN_OUT:
        signOut(context);
        break;
    }
  }

  void signOut(BuildContext context) async {
    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.signOut();
    //ログイン画面に移動 ログイン画面からpopできないようにpushReplacement使う
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginScreen()
    ),);
  }
}
