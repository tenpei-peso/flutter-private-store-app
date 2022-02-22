import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/feed/pages/sub/feed_sub_page.dart';
import 'package:pesostagram/view/post/screens/post_screen.dart';

class FeedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pesostagram", style: TextStyle(fontFamily: TitleFont),),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.cameraRetro, color: Colors.black54,),
          onPressed: () => _launchCamera(context),
        ),
      ),
      body: FeedSubPage(
        feedMode: FeedMode.FROM_FEED,
        index: 0,
      ),

    );
  }

  _launchCamera(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => PostScreen(uploadType: UploadType.CAMERA)
    ));
  }
}
