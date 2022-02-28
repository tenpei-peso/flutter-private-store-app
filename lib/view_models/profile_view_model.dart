import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  bool isFollowingProfileUser = false;

  void setProfileUser(ProfileMode profileMode, User? selectedUser) {
    if (profileMode == ProfileMode.MYSELF) {
      profileUser = currentUser;
    } else {
      profileUser = selectedUser!;
      //ユーザーをフォローしているか確認
      checkIsFollowing();
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

  Future<String> pickProfileImage() async {
    final pickedImage = await postRepository.pickImage(UploadType.GALLERY);
    return (pickedImage != null) ? pickedImage.path : "";
  }

  Future<void> updateProfile(String name, String bio, String photoUrl, bool isImageFromFile) async {
    isProcessing = true;
    notifyListeners();
    await userRepository.updateProfile(
      profileUser,
      name,
      bio,
      photoUrl,
      isImageFromFile
    );

    //更新後にcurrentUserを更新する
    await userRepository.getCurrentUserById(profileUser.userId);
    //プロフィール更新は自分しかできないので、currentUser入れても大丈夫
    profileUser = currentUser;

    isProcessing = false;
    notifyListeners();
  }

  Future<void> follow() async {
    await userRepository.follow(profileUser);
    isFollowingProfileUser = true;
    notifyListeners();
  }

  Future<void> checkIsFollowing() async {
    isFollowingProfileUser = await userRepository.checkIsFollowing(profileUser);
    notifyListeners();
  }

  Future<void> unFollow() async {
    await userRepository.unFollow(profileUser);
    isFollowingProfileUser = false;
    notifyListeners();
  }


}