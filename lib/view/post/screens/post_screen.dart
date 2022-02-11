import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/common/dailog/confirm_dialog.dart';
import 'package:pesostagram/view/post/components/post_caption_part.dart';
import 'package:pesostagram/view/post/components/post_location_part.dart';
import 'package:pesostagram/view_models/post_view_model.dart';
import 'package:provider/provider.dart';


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
              leading: model.isProcessing
                  ? Container()
                  : IconButton(
                      onPressed: () => _cancelPost(context),
                      icon: Icon(Icons.arrow_back),
                  ),
              title: model.isProcessing
                  ? Text("処理中です")
                  : Text("投稿"),
              actions: [
                (model.isProcessing || !model.isImagePicked)
                    ? IconButton(
                        onPressed: () => _cancelPost(context),
                        icon: Icon(Icons.close),
                      )
                    : IconButton(
                        //ダイアログ
                        onPressed: () => showConfirmDialog(
                            context: context,
                            title: "投稿",
                            content: "投稿してもよろしいですか？",
                            onConfirmed: (bool isConfirmed) {
                              if(isConfirmed) {
                                _post(context);
                              }
                            }
                        ),
                        icon: Icon(Icons.done),
                    )
              ], //actions widget,
            ),
            body: model.isProcessing
                ? Center(
                  child: CircularProgressIndicator(),
                )
                : Column(
                  children: [
                    Divider(),
                    PostCaptionPart(from: PostCaptionOpenMode.FROM_POST),
                    Divider(),
                    PostLocationPart(),
                    Divider()
                  ],
                )
          );
        }
    );
  }

  _cancelPost(BuildContext context) async {
    final postViewModel = context.read<PostViewModel>();
    postViewModel.cancelPost();
    Navigator.pop(context);
  }
  //TODO 投稿
  void _post(BuildContext context) async {
    final postViewModel = context.read<PostViewModel>();
    await postViewModel.post();
    Fluttertoast.showToast(msg: "投稿に成功しました");
    Navigator.pop(context);
  }



}
