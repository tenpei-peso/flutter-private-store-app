import 'package:flutter/material.dart';
import 'package:pesostagram/view/common/components/circle_photo.dart';
import 'package:pesostagram/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../style.dart';

class ProfileImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();

    return Container(
      height: 170.0,
      color: Colors.green,
      alignment: const Alignment(0, 0),
      child: Column(
        children: [
          SizedBox(height: 30,),
          CirclePhoto(
            photoUrl: profileViewModel.profileUser.photoUrl,
            isImageFromFile: false,
            radius: 45.0,
          ),
          SizedBox(height: 10,),
          Text(profileViewModel.profileUser.inAppUserName, style: profileNameTextStyle,),
        ],
      )
    );
  }
}
