import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../style.dart';

class FeedPostLikesPart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: null,
                  icon: FaIcon(FontAwesomeIcons.solidHeart)
              ),
              IconButton(
                  onPressed: null,
                  icon: FaIcon(FontAwesomeIcons.comment)
              ),
            ],
          ),

          Text("0 いいね", style: numberOfLikesTextStyle,),
        ],
      ),
    );
  }
}
