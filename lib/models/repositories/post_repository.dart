import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pesostagram/deta_models/comments.dart';
import 'package:pesostagram/deta_models/like.dart';
import 'package:pesostagram/deta_models/location.dart';
import 'package:pesostagram/deta_models/post.dart';
import 'package:pesostagram/deta_models/user.dart';
import 'package:pesostagram/models/db/database_manager.dart';
import 'package:pesostagram/models/location/location_manager.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:uuid/uuid.dart';

import '../../deta_models/item.dart';

class PostRepository {
  final DatabaseManager dbManager;
  final LocationManager locationManager;

  PostRepository({required this.dbManager, required this.locationManager});

  Future<File?> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();
     if(uploadType == UploadType.GALLERY) {
       final pickedImage =  await imagePicker.pickImage(source: ImageSource.gallery);
       return (pickedImage != null) ? File(pickedImage.path) : null;
     } else {
       final pickedCameraImage =  await imagePicker.pickImage(source: ImageSource.camera);
       return (pickedCameraImage != null) ? File(pickedCameraImage.path) : null;
     }
  }

  Future<Location?> getCurrentLocation() async {
    return await locationManager.getCurrentLocation();
  }

  Future<Location?> updateLocation(double latitude, double longitude) async {
    return await locationManager.updateLocation(latitude, longitude);
  }

  Future<void> post(User currentUser, File imageFile, String caption, Location? location, String locationString) async {
    //TODO 投稿処理
    final storageId = Uuid().v1();
    // fireStorageのファイルURL
    final imageUrl = await dbManager.uploadImageStorage(imageFile, storageId);

    final post = Post(
        postId: Uuid().v1(),
        userId: currentUser.userId,
        imageUrl: imageUrl,
        imageStoragePath: storageId, //fire storageのid
        caption: caption,
        locationString: locationString,
        latitude: (location != null) ? location.latitude : 0.0,
        longitude: (location != null) ? location.longitude : 0.0,
        postDateTime: DateTime.now()
    );
    await dbManager.insertPost(post);

  }

  Future<List<Post>> getPost(FeedMode feedMode, User feedUser) async {
    if (feedMode == FeedMode.FROM_FEED) {
      return await dbManager.getPostMineAndFollowings(feedUser.userId);
    } else {
      return dbManager.getPostsByUser(feedUser.userId);
    }
  }

  Future<void> updatePost(Post updatePost) async {
    return await dbManager.updatePost(updatePost);
  }

  Future<void> postComment(Post post, User postUser, String commentString) async {
    final comment = Comment(
        commentId: Uuid().v1(),
        postId: post.postId,
        commentUserId: postUser.userId,
        comment: commentString,
        commentDataTime: DateTime.now()
    );
    await dbManager.postComment(comment);

  }

  Future<List<Comment>> getComments(String postId) async {
    return await dbManager.getComments(postId);
  }

  Future<void> deleteComment(String deleteCommentId) async {
    return await dbManager.deleteComment(deleteCommentId);
  }

  Future<void> likeIt(Post post, User currentUser) async {
    final like = Like(
        likeId: Uuid().v1(),
        postId: post.postId,
        likeUserId: currentUser.userId,
        likeDateTime: DateTime.now()
    );
    await dbManager.likeIt(like);
  }

  Future<void> unLikeIt(Post post, User currentUser) async {
    await dbManager.unLikeIt(post, currentUser);
  }

  Future<LikeResult> getLikeResult(String postId, User currentUser) async {
    //いいねの取得
    final likes = await dbManager.getLikes(postId);
    //いいねしたかどうか判定
    var isLikedPost = false;
    //for in使うのはbreakが使えるから。foreachだとリスト全部を回してしまう。
    for (var like in likes) {
      if(like.likeUserId == currentUser.userId) {
        isLikedPost = true;
        break;
      }
    }
    return LikeResult(likes: likes, isLikedToThisPost: isLikedPost);
  }

  Future<void> deletePost(String postId, String imageStoragePath) async {
    return await dbManager.deletePost(postId, imageStoragePath);
  }
  //オーナーIdから一致するitemとってくる
  Future<List<Item>> getItemByOwnerId(String ownerId) async {
    return await dbManager.getItemByOwnerId(ownerId);
  }



}