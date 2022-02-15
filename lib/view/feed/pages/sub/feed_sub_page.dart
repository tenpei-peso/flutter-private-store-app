import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view_models/feed_view_model.dart';
import 'package:provider/provider.dart';

import '../../components/feed_post_tile.dart';

class FeedSubPage extends StatelessWidget {
  final FeedMode feedMode;

  const FeedSubPage({required this.feedMode});

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();
    //TODO プロフィールから来た場合はUserの設定要
    //sub_pageが呼ばれると呼び出した画面に応じてユーザー情報とる
    feedViewModel.setFeedUser(feedMode, null);

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
                : ListView.builder(
                  itemCount: model.posts!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FeedPostTile( feedMode: feedMode, post: model.posts![index],);
                  }
                );
          }

        }
    );
  }
}
