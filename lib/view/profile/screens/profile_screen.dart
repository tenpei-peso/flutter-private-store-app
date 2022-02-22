import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';

import '../../../deta_models/user.dart';
import '../pages/profile_page.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileMode profileMode;
  final User? selectedUser;

  const ProfileScreen({required this.profileMode, this.selectedUser});

  @override
  Widget build(BuildContext context) {
    return ProfilePage(profileMode: profileMode, selectedUser: selectedUser);
  }
}
