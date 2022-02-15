import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pesostagram/deta_models/post.dart';
import 'package:pesostagram/deta_models/user.dart';

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

  Future<List<String>> getFollowingUserIds(String userId) async {
    final query = await _db.collection("users").doc(userId).collection("following").get();
    if (query.docs.length == 0) return [];

    var userIds = <String>[];
    query.docs.forEach((id) {
      userIds.add(id.data()["userId"]);
    });
    return userIds;

  }
// TODO
  // Future<List<Post>> getPostsByUser(String userId) {
  //
  // }

}