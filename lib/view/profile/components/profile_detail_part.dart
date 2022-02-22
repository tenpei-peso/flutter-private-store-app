import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/profile/components/sub/profile_bio.dart';
import 'package:pesostagram/view/profile/components/sub/profile_image.dart';

class ProfileDetailPart extends StatelessWidget {
  final ProfileMode profileMode;

  const ProfileDetailPart({required this.profileMode});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImage(),
        ProfileBio(profileMode: profileMode,),
      ],
    );
  }
}
