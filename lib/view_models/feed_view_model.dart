import 'package:flutter/material.dart';
import 'package:pesostagram/models/repositories/post_repository.dart';
import 'package:pesostagram/models/repositories/user_repository.dart';
import 'package:pesostagram/utils/constants.dart';

import '../deta_models/post.dart';
import '../deta_models/user.dart';

class FeedViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;


  FeedViewModel({required this.userRepository, required this.postRepository});

  bool isProcessing = false;
  List<Post>? posts = [];

  String caption = "";

  late User feedUser; //ページ毎に必要なユーザーの情報
  User get currentUser => UserRepository.currentUser!;

  void setFeedUser(FeedMode feedMode, User? user) {
    if(feedMode == FeedMode.FROM_FEED) {
      feedUser = currentUser;
    } else {
      feedUser = user!;
    }
  }

  Future<void> getPosts(FeedMode feedMode) async {
    isProcessing = true;
    notifyListeners();

    posts = await postRepository.getPost(feedMode, feedUser);
    isProcessing = false;
    notifyListeners();
  }

  Future<User> getPostUserInfo(String userId) async {
    return await userRepository.getUserById(userId);
  }

  Future<void> updatePost(Post post, FeedMode feedMode) async {
    isProcessing = true;

    await postRepository.updatePost(
      post.copyWith(caption: caption)
    );

    await getPosts(feedMode);
    isProcessing = false;
    notifyListeners();
  }

}