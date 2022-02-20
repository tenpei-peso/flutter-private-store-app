import 'package:flutter/material.dart';
import 'package:pesostagram/deta_models/comments.dart';
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
  List<Comment> comments = [];

  bool isLoading = false;

  Future<void> postComment(Post post) async{
    // currentUserはコメントしたユーザー
    await postRepository.postComment(post, currentUser, comment);
    getComments(post.postId);
    notifyListeners();
  }

  Future<void> getComments(String postId) async {
    isLoading = true;
    notifyListeners();

    comments = await postRepository.getComments(postId);
    print("コメント${comments}");
    isLoading = false;
    notifyListeners();

  }

  Future<User> getCommentUserInfo(String commentUserId) async {
    return await userRepository.getUserById(commentUserId);
  }

  Future<void> deleteComment(Post post, Comment currentComment) async {
    final deleteCommentId = currentComment.commentId;
    await postRepository.deleteComment(deleteCommentId);
    getComments(post.postId);
    notifyListeners();
  }
}