import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view_models/feed_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../deta_models/user.dart';
import '../../components/feed_post_tile.dart';

class FeedSubPage extends StatelessWidget {
  final FeedMode feedMode;
  final User? feedUser;
  final int index;

  const FeedSubPage({required this.feedMode, this.feedUser, required this.index});

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();
    // プロフィールから来た場合はUserの設定要
    //sub_pageが呼ばれると呼び出した画面に応じてユーザー情報とる
    feedViewModel.setFeedUser(feedMode, feedUser);

    Future<void>(() => feedViewModel.getPosts(feedMode));

    return Consumer<FeedViewModel>(
        builder: (context, model, child) {
          if(model.isProcessing) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return (model.posts == null)
                ? Container()
                : RefreshIndicator(   //上にスクロールすると更新
                  onRefresh: () => model.getPosts(feedMode),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: model.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FeedPostTile( feedMode: feedMode, post: model.posts[index],);
                    }
                  ),
                );
          }

        }
    );
  }
}
