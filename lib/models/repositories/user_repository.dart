import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pesostagram/deta_models/user.dart';
import 'package:pesostagram/models/db/database_manager.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  final DatabaseManager dbManager;

  UserRepository({required this.dbManager});

  static User? currentUser;

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> isSignIn() async {
    final firebaseUser = _auth.currentUser;
    if(firebaseUser != null) {
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    }
    return false;
  }

  Future<bool> signIn() async {
    try {
      GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
      if (signInAccount == null) return false;

      GoogleSignInAuthentication signInAuthentication = await signInAccount.authentication;
      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken,
      );

      final firebaseUser = (await _auth.signInWithCredential(credential)).user;
      //.userはfirebaseUser.userと同じ
      if (firebaseUser == null) {
        return false;
      }
      //DBに登録
      final isUserExistedInDb = await dbManager.searchUserInDb(firebaseUser);
      if(!isUserExistedInDb) {
        await dbManager.insertUser(_convertToUser(firebaseUser));
      }
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    } catch(error) {
      print("sign in error${error.toString()}");
      return false;
    }
  }

  Future<bool> emailRegister(String emailString, String passwordString) async {
    try {
      final auth.UserCredential userInfo = await _auth.createUserWithEmailAndPassword(
          email: emailString,
          password: passwordString
      );
      final firebaseUser = userInfo.user;
      if (firebaseUser == null) {
        return false;
      }
      //DBに登録
      final isUserExistedInDb = await dbManager.searchUserInDb(firebaseUser);
      if(!isUserExistedInDb) {
        await dbManager.insertUser(_convertToUser(firebaseUser));
      }
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;

    } catch(error) {
      print("email register error");
      return false;
    }
  }

  Future<bool> emailSignIn(String emailString, String passwordString) async {
    try {
      final auth.UserCredential userInfo = await _auth.signInWithEmailAndPassword(
          email: emailString,
          password: passwordString
      );
      final firebaseUser = userInfo.user;
      if (firebaseUser == null) {
        return false;
      }
      //DBに登録
      final isUserExistedInDb = await dbManager.searchUserInDb(firebaseUser);
      if(!isUserExistedInDb) {
        await dbManager.insertUser(_convertToUser(firebaseUser));
      }
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    } catch(error) {
      print("email register error");
      return false;
    }

  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    //staticで残しているので前のログイン情報残るからnullにする
    currentUser = null;
  }

  User _convertToUser(auth.User firebaseUser) {
    return User(
      userId: firebaseUser.uid,
      displayName: firebaseUser.displayName ?? "",
      inAppUserName: firebaseUser.displayName ?? "",
      photoUrl: firebaseUser.photoURL ?? "",
      email: firebaseUser.email ?? "",
      bio: "",
    );
  }

  Future<User> getUserById(String userId) async {
    return await dbManager.getUserInfoFromDbById(userId);
  }

  Future<int> getNumberOfFollowers(User profileUser) async {
    return (await dbManager.getFollowerUserIds(profileUser.userId)).length;
  }

  Future<int> getNumberOfFollowings(User profileUser) async {
    return (await dbManager.getFollowingUserIds(profileUser.userId)).length;

  }

  Future<void> updateProfile(User profileUser, String name, String bio, String photoUrl, bool isImageFromFile) async {
    var updatePhotoUrl;

    if(isImageFromFile) {
      //storageのURLとってくる
      final updatePhotoFile = File(photoUrl);
      final storagePath = Uuid().v1();
      updatePhotoUrl = await dbManager.uploadImageStorage(updatePhotoFile, storagePath);
    }

    final updateUser = profileUser.copyWith(
      inAppUserName: name,
      bio: bio,
      photoUrl: isImageFromFile ? updatePhotoUrl : profileUser.photoUrl,
    );

    await dbManager.updateProfile(updateUser);

  }

  Future<void> getCurrentUserById(String userId) async {
    currentUser = await dbManager.getUserInfoFromDbById(userId);
  }

  Future<List<User>> searchUsers(String query) async {
    return  dbManager.searchUsers(query);
  }

  Future<void> follow(User profileUser) async {
    if(currentUser != null) await dbManager.follow(profileUser, currentUser!);
  }

  Future<bool> checkIsFollowing(User profileUser) async {
    return (currentUser != null)
        ? await dbManager.checkIsFollowing(profileUser, currentUser!)
        : false;

  }

  Future<void> unFollow(User profileUser) async {
     if(currentUser != null) await dbManager.unFollow(profileUser, currentUser!);
  }

  Future<List<User>> getCaresUserData(String id, WhoCaresMeMode mode) async {
    var result = <User>[];
    
    switch (mode) {
      case WhoCaresMeMode.LIKE:
        final postId = id;
        result = await dbManager.getLikesUsers(postId);
        break;
      case WhoCaresMeMode.FOLLOWINGS:
        final profileUserId = id;
        result = await dbManager.getFollowerUsers(profileUserId);
        break;
      case WhoCaresMeMode.FOLLOWED:
        final profileUserId = id;
        result = await dbManager.getFollowingUsers(profileUserId);
        break;
    }
    return result;

  }

  }
