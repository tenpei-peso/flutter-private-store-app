import 'package:flutter/material.dart';
import 'package:pesostagram/deta_models/post.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/feed/components/sub/image_from_url.dart';
import 'package:pesostagram/view_models/feed_view_model.dart';
import 'package:provider/provider.dart';

import '../../feed/components/screens/feed_screen.dart';

class ProfilePostsGridPart extends StatelessWidget {
  final List<Post> posts;

  const ProfilePostsGridPart({required this.posts});
  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
        crossAxisCount: 3,
        //リストが必要
        children: posts.isEmpty
          ? [Container()]
          : List.generate(  //リストを生成してくれる。foreachはリストから取り出して処理
            posts.length,
            (int index) => InkWell(
              onTap: () => _openFeedScreen(context, index),
              child: ImageFromUrl(
                imageUrl: posts[index].imageUrl,
                // height: 130.0,
                // width: 130.0,
              ),
            ),
        ),
    );
  }

  void _openFeedScreen(BuildContext context, int index) {
    final profileViewModel = context.read<FeedViewModel>();
    final feedUser = profileViewModel.feedUser;

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => FeedScreen(
          feedUser: feedUser,
          index: index,
          feedMode: FeedMode.FROM_PROFILE,
        );
    ));
  }
}
