import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';

import '../deta_models/post.dart';
import '../deta_models/user.dart';
import '../models/repositories/post_repository.dart';
import '../models/repositories/user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  ProfileViewModel({required this.userRepository, required this.postRepository});

  late User profileUser;
  User get currentUser => UserRepository.currentUser!;

  bool isProcessing = false;

  List<Post> posts = [];

  void setProfileUser(ProfileMode profileMode, User? selectedUser) {
    if (profileMode == ProfileMode.MYSELF) {
      profileUser = currentUser;
    } else {
      profileUser = selectedUser!;
    }
  }

  Future<void> getPost() async {
    isProcessing = true;
    notifyListeners();

    posts = await postRepository.getPost(FeedMode.FROM_PROFILE, profileUser);
    isProcessing = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await userRepository.signOut();
  }

  Future<int> getNumberOfFollowers() async {
    return await userRepository.getNumberOfFollowers(profileUser);
  }

  Future<int> getNumberOfFollowings() async {
    return await userRepository.getNumberOfFollowings(profileUser);

  }


}