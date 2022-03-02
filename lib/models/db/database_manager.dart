import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pesostagram/deta_models/comments.dart';
import 'package:pesostagram/deta_models/like.dart';
import 'package:pesostagram/deta_models/post.dart';
import 'package:pesostagram/deta_models/user.dart';
import 'package:pesostagram/models/repositories/user_repository.dart';

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> searchUserInDb(auth.User firebaseUser) async {
    final query = await _db
        .collection("users")
        .where("userId", isEqualTo: firebaseUser.uid)
        .get();
    if (query.docs.length > 0) {
      return true;
    }
    return false;
  }

  Future<void> insertUser(User user) async {
    await _db.collection("users").doc(user.userId).set(user.toMap());
  }

  //userIdからユーザーとってくる
  Future<User> getUserInfoFromDbById(String userId) async {
    final query = await _db.collection("users").where(
        "userId", isEqualTo: userId).get();
    
    return User.fromMap(query.docs[0].data());
  }

  Future<String> uploadImageStorage(File imageFile, String storageId) async {
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    final uploadTask = storageRef.putFile(imageFile);
    return await uploadTask.then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }

  Future<List<Post>> getPostsByUser(String userId) async {
    final query = await _db.collection("posts").get();
    if (query.docs.length == 0) return [];

    var results = <Post>[];
    await _db.collection("posts").where("userId", isEqualTo: userId).orderBy("postDateTime", descending: true).get()
        .then((value) => value.docs.forEach((element) {
      results.add(Post.fromMap(element.data()));
    }));
    return results;
  }

  Future<void> insertPost(Post post) async {
    await _db.collection("posts").doc(post.postId).set(post.toMap());
  }

  Future<List<Post>> getPostMineAndFollowings(String userId) async {
    // データの有無を判定
    final query = await _db.collection("posts").get();
    if (query.docs.length == 0) return [];

    //フォロワーのIdをとってくる
    var userIds = await getFollowingUserIds(userId);
    //フォロワーと自分のIDを合わせる
    userIds.add(userId);

    var results = <Post>[];
    //whereInは10以上の数があるとエラー出る
    await _db.collection("posts").where("userId", whereIn: userIds).orderBy("postDateTime", descending: true).get()
      .then((value) => value.docs.forEach((element) {
        results.add(Post.fromMap(element.data()));
    }));
    return results;
  }

  // 渡したidのユーザのフォローしているユーザーのidとってくる
  Future<List<String>> getFollowingUserIds(String userId) async {
    final query = await _db.collection("users").doc(userId).collection("followings").get();
    if (query.docs.length == 0) return [];

    var userIds = <String>[];
    query.docs.forEach((id) {
      userIds.add(id.data()["userId"]);
    });
    return userIds;

  }

  // 渡したidのユーザのフォローされているユーザーのidとってくる
  Future<List<String>> getFollowerUserIds(String userId) async {
    final query = await _db.collection("users").doc(userId).collection("followers").get();
    if (query.docs.length == 0) return [];
    var userIds = <String>[];
    query.docs.forEach((id) {
      userIds.add(id.data()["userId"]);
    });
    return userIds;
  }

  Future<void> updatePost(Post updatePost) async {
    final reference = _db.collection("posts").doc(updatePost.postId);
    await reference.update(updatePost.toMap());
  }

  Future<void> postComment(Comment comment) async {
    await _db.collection("comments").doc(comment.commentId).set(comment.toMap());
  }

  Future<List<Comment>> getComments(String postId) async {
    final query = await _db.collection("comments").get();
    if (query.docs.length == 0) return [];

    var results = <Comment>[];
    await _db.collection("comments").where("postId", isEqualTo: postId).orderBy("commentDataTime").get()
    .then((value) {
      value.docs.forEach((element) {
        results.add(Comment.fromMap(element.data()));
      });
    });
    return results;
  }

  Future<void> deleteComment(String deleteCommentId) async {
    final reference = _db.collection("comments").doc(deleteCommentId);
    await reference.delete();
  }

  Future<void> likeIt(Like like) async {
    await _db.collection("likes").doc(like.likeId).set(like.toMap());
  }

  Future<void> unLikeIt(Post post, User currentUser) async {
    //全いいねの中から今の投稿に関するものかつ、自分がいいねしたものをとってくる。
    final likeRef = await _db.collection("likes")
        .where("postId", isEqualTo: post.postId)
        .where("likeUserId", isEqualTo: currentUser.userId).get();

    likeRef.docs.forEach((element) async {
      print(element.data());
      await _db.collection("likes").doc(element.id).delete();
    });
  }
  //いいねの数とってくる
  Future<List<Like>> getLikes(String postId) async {
    final query = await _db.collection("likes").get();
    if (query.docs.length == 0) return [];
    var results = <Like>[];
    await _db.collection("likes").where("postId", isEqualTo: postId).orderBy("likeDateTime").get()
        .then((value) {
      value.docs.forEach((element) {
        results.add(Like.fromMap(element.data()));
      });
    });
    return results;
  }
  //いいねしたユーザーをとってくる
  Future<List<User>> getLikesUsers(String postId) async {
    final query = await _db.collection("likes").where("postId", isEqualTo: postId).get();
    if (query.docs.length == 0) return [];
    //いいねしたユーザーのIDとってくる
    var userIds = <String>[];
    query.docs.forEach((id) {
      userIds.add(id.data()["likeUserId"]);
    });
    //IDをもとにユーザーのリストとってくる
    var likesUsers = <User>[];
    await Future.forEach(userIds, (String userId) async { //getUser関数は非同期なので、forEachの処理がawaitしないとうまくいかない
      final user = await getUserInfoFromDbById(userId);
      likesUsers.add(user);
    });
    return likesUsers;
  }
  //フォロー中のユーザとってくる
  Future<List<User>> getFollowerUsers(String profileUserId) async {
    final followerUserIds = await getFollowingUserIds(profileUserId);
    var followerUsers = <User>[];
    await Future.forEach(followerUserIds, (String userId) async {
      final user = await getUserInfoFromDbById(userId);
      followerUsers.add(user);
    });
    print("フォロー${followerUsers}");
    return followerUsers;
  }

  //フォロワーとってくる
  Future<List<User>> getFollowingUsers(String profileUserId) async {
    final followingUserIds = await getFollowerUserIds(profileUserId);
    var followingUsers = <User>[];
    await Future.forEach(followingUserIds, (String userId) async {
      final user = await getUserInfoFromDbById(userId);
      followingUsers.add(user);
    });
    return followingUsers;
  }

  //投稿、コメント、いいね、storageの画像全て消す
  Future<void> deletePost(String postId, String imageStoragePath) async {
    //Post
    final postRef = _db.collection("posts").doc(postId);
    await postRef.delete();

    //Comment
    final commentRef = await _db.collection("comments").where("postId", isEqualTo: postId).get();
    commentRef.docs.forEach((element) async {
      final ref = _db.collection("comments").doc(element.id);
      await ref.delete();
    });

    //Likes
    final likeRef = await _db.collection("likes").where("postId", isEqualTo: postId).get();
    likeRef.docs.forEach((element) async {
      final ref = _db.collection("likes").doc(element.id);
      await ref.delete();
    });

    //Storage
    final storageRef = FirebaseStorage.instance.ref().child(imageStoragePath);
    storageRef.delete();
  }

  Future<void> updateProfile(User updateUser) async {
    final reference = _db.collection("users").doc(updateUser.userId);
    await reference.update(updateUser.toMap());
  }

  Future<List<User>> searchUsers(String queryString) async {
    final query = await _db.collection("users").orderBy("inAppUserName")
        .startAt([queryString]).endAt([queryString + "\uf8ff"]).get();  //検索でお決まり
    if (query.docs.length == 0) return [];

    var soughtUsers = <User>[];
    query.docs.forEach((element) {
      final selectedUser = User.fromMap(element.data());
      if(selectedUser.userId != UserRepository.currentUser?.userId) {
        soughtUsers.add(selectedUser);
      }
    });

    return soughtUsers;

  }

  Future<void> follow(User profileUser, User currentUser) async {
    //currentUserからはfollowする
    await _db.collection("users").doc(currentUser.userId)
        .collection("followings").doc(profileUser.userId)
        .set({"userId": profileUser.userId});

    //profileUserはfollowされる
    await _db.collection("users").doc(profileUser.userId)
    .collection("followers").doc(currentUser.userId)
    .set({"userId": currentUser.userId});
  }

  Future<bool> checkIsFollowing(User profileUser, User currentUser) async {
    final query = await _db.collection("users").doc(currentUser.userId).collection("followings").get();
    if (query.docs.length == 0) return false;

    final checkQuery = await _db.collection("users").doc(currentUser.userId).collection("followings")
    .where("userId", isEqualTo: profileUser.userId).get();

    if(checkQuery.docs.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> unFollow(User profileUser, User currentUser) async {
    //currentUserのfollowingから削除
    await _db.collection("users").doc(currentUser.userId)
        .collection("followings").doc(profileUser.userId)
        .delete();
    //profileUserのfollowersから削除
    await _db.collection("users").doc(profileUser.userId)
        .collection("followers").doc(currentUser.userId)
        .delete();

  }





}