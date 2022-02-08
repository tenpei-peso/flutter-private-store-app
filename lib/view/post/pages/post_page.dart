import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/common/components/button_with_icon.dart';
import 'package:pesostagram/view/post/screens/post_screen.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ButtonWithIcon(
              iconData: FontAwesomeIcons.image,
              label: "ギャラリー",
              onPressed: () =>
                  _openPostUploadScreen(UploadType.GALLERY, context),
            ),
            SizedBox(
              height: 24.0,
            ),
            ButtonWithIcon(
              iconData: FontAwesomeIcons.camera,
              label: "カメラ",
              onPressed: () =>
                  _openPostUploadScreen(UploadType.CAMERA, context),
            ),
          ], // Column children
        ),
      )),
    );
  }

  _openPostUploadScreen(UploadType uploadType, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => PostScreen(
                uploadType: uploadType,
              )),
    );
  }
}
