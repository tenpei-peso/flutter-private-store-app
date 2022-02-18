import 'package:flutter/material.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/utils/functions.dart';
import 'package:pesostagram/view/common/components/circle_photo.dart';
import 'package:pesostagram/view/common/components/comment_rich_text.dart';

class CommentDisplayPart extends StatelessWidget {
  final String postUserPhotoUrl;
  final String name;
  final String text;
  final DateTime postDateTime;

  const CommentDisplayPart({required this.postUserPhotoUrl, required this.name, required this.text, required this.postDateTime});


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CirclePhoto(photoUrl: postUserPhotoUrl, isImageFromFile: false),
        SizedBox(width: 8.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommentRichText(
                name: name,
                text: text,
              ),
              Text(
                createTimeAgoString(postDateTime),
                style: TimeTextStyle,
              )
            ],
          ),
        )
      ],
    );
  }
}
