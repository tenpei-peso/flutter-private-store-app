import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/post/components/post_caption_part.dart';
import 'package:pesostagram/view/post/components/post_location_part.dart';
import 'package:pesostagram/view_models/post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class PostScreen extends StatelessWidget {
  final UploadType uploadType;

  PostScreen({required this.uploadType});

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.read<PostViewModel>();
    if (!postViewModel.isImagePicked && !postViewModel.isProcessing) {
      Future(() => postViewModel.pickImage(uploadType));
    }

    return Consumer<PostViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: model.isProcessing ? Container() : IconButton(
                  onPressed: () => _cancelPost(context),
                  icon: Icon(Icons.arrow_back),
              ),
              title: model.isProcessing ? Text("処理中です") : Text("投稿"),
              actions: [
                (model.isProcessing || !model.isImagePicked) ? IconButton(
                  onPressed: () => _cancelPost(context),
                  icon: Icon(Icons.close),
                ) : IconButton(
                      //TODO ダイアログ
                      onPressed: null,
                      icon: Icon(Icons.done),
                    )
              ], //actions widget,
            ),
            body: model.isProcessing
                ? Center(
                  child: CircularProgressIndicator(),
                )
                : model.isImagePicked
                ? Column(
                  children: [
                    Divider(),
                    PostCaptionPart(from: PostCaptionOpenMode.FROM_POST),
                    Divider(),
                    PostLocationPart(),
                    Divider()
                  ],
                )
                : Container()
          );
        }
    );
  }

  _cancelPost(BuildContext context) {
    Navigator.pop(context);
  }


}
