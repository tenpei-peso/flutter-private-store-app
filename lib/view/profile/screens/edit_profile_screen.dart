import 'package:flutter/material.dart';
import 'package:pesostagram/view/common/components/circle_photo.dart';
import 'package:pesostagram/view/common/dailog/confirm_dialog.dart';
import 'package:pesostagram/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../style.dart';

class EditProfileScreen extends StatefulWidget {

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String photoUrl = "";
  bool _isImageFromFile = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    final profileViewModel = context.read<ProfileViewModel>();
    final profileUser = profileViewModel.profileUser;
    _isImageFromFile = false;
    photoUrl = profileUser.photoUrl;

    nameController.text = profileUser.inAppUserName;
    bioController.text = profileUser.bio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("プロフィールの編集"),
        actions: [
          IconButton(
              icon: Icon(Icons.done),
              // TODO
              onPressed: () => showConfirmDialog(
                  context: context,
                  title: "プロフィールを編集",
                  content: "プロフィールを編集してもよろしいですか？",
                  onConfirmed: (isConfirmed) {
                    if (isConfirmed) {
                      updateProfile(context);
                    }
                  }
              ),
          )
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, model, child) {
          return model.isProcessing
              ? Center(child: CircularProgressIndicator(),)
              : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0,),
                  Center(
                      child: (photoUrl == "")
                          ? Container()
                          : CirclePhoto(photoUrl: photoUrl, isImageFromFile: _isImageFromFile, radius: 60.0,)
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => _pickNewProfileImage(),
                      child: Text("プロフィール写真を変更", style: changeProfilePhotoTextStyle,),
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Text("Name", style: commentInputTextStyle),
                  TextField(
                    controller: nameController,
                  ),
                  SizedBox(height: 16.0,),
                  Text("Bio", style: commentInputTextStyle),
                  TextField(
                    controller: bioController,
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }

  //写真とってきて、setStateで画面再描画
  Future<void> _pickNewProfileImage() async {
    _isImageFromFile = false;
    final profileViewModel = context.read<ProfileViewModel>();
    photoUrl = await profileViewModel.pickProfileImage();
    setState(() {
      _isImageFromFile = true;
    });
  }
  //actionが押された時にDBに登録する
  void updateProfile(BuildContext context) async {
    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.updateProfile(
      nameController.text,
      bioController.text,
      photoUrl,
      _isImageFromFile,
    );

    Navigator.pop(context);
  }
}
