import 'package:firebase_auth/firebase_auth.dart';  //TODO 後で消す
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart'; //TODO 後で消す
import 'package:pesostagram/style.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/feed/pages/sub/feed_sub_page.dart';
import 'package:pesostagram/view/login/screens/login_screen.dart';
import 'package:pesostagram/view/post/screens/post_screen.dart';

class FeedPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pesostagram", style: TextStyle(fontFamily: TitleFont),),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.cameraRetro, color: Colors.black54,),
          onPressed: () => _launchCamera(context),
        ),
        // <------------------------------------ 消す
        actions: [
          TextButton(  //TODO 消す 簡易ログアウト
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              await _googleSignIn.signOut();
              await Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            },
            child: Text('Logout', style: TextStyle(fontSize: 10, color: Colors.white)),
          )
        ],
      ),
      // <---------------------------------
      body: FeedSubPage(
        feedMode: FeedMode.FROM_FEED,
      ),

    );
  }

  _launchCamera(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => PostScreen(uploadType: UploadType.CAMERA)
    ));
  }
}
