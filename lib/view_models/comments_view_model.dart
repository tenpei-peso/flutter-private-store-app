import 'package:flutter/material.dart';
import 'package:pesostagram/deta_models/post.dart';

import '../deta_models/user.dart';
import '../models/repositories/post_repository.dart';
import '../models/repositories/user_repository.dart';

class CommentsViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;

  CommentsViewModel({required this.userRepository, required this.postRepository});

  User get currentUser => UserRepository.currentUser!;
  String comment = "";

  Future<void> postComment(Post post) async{
    // currentUserはコメントしたユーザー
    await postRepository.postComment(post, currentUser, comment);
    notifyListeners();
  }
}