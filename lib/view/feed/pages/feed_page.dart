import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/feed/pages/sub/feed_sub_page.dart';
import 'package:pesostagram/view/post/screens/post_screen.dart';
import 'package:pesostagram/view/search/pages/search_page.dart';

class FeedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("ShoppingMap", style: GoogleFonts.fredokaOne(
            fontSize: 20, textStyle: Theme.of(context).textTheme.headline6, color: Colors.white
        )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.elliptical(90, 30),
          ),
        ),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.cameraRetro, color: Colors.white,),
          onPressed: () => _launchCamera(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              icon: Icon(Icons.group_add),
              onPressed: () => searchFriend(context),
            ),
          ),
        ],
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

  searchFriend(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => SearchPage()
    ));
  }
}
