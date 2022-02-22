import 'package:flutter/material.dart';
import 'package:pesostagram/view/feed/pages/sub/feed_sub_page.dart';

import '../../../../deta_models/user.dart';
import '../../../../utils/constants.dart';

class FeedScreen extends StatelessWidget {
  final User feedUser;
  final int index;
  final FeedMode feedMode;
  //FeedScreenはプロフィール画面から飛んでくる画面
  const FeedScreen({required this.feedUser, required this.index, required this.feedMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("投稿"),
      ),
      body: FeedSubPage(feedMode: feedMode, index: index,),
    );
  }
}
