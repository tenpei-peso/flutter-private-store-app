import 'package:flutter/material.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view_models/post_view_model.dart';
import 'package:provider/src/provider.dart';

import '../../../view_models/feed_view_model.dart';

class PostCaptionInputTextField extends StatefulWidget {
  final String? caption;
  final PostCaptionOpenMode? from;

  const PostCaptionInputTextField({this.caption, this.from});

  @override
  _PostCaptionInputTextFieldState createState() => _PostCaptionInputTextFieldState();
}

class _PostCaptionInputTextFieldState extends State<PostCaptionInputTextField> {
  final _captionController = TextEditingController();

  // onChanged方式」は、ユーザーがデバイス上でTextFieldの値を変更した場合のみ発動される一方、
  // 「addListener方式」の場合は、TextFieldの値が動的に（programmatically）変更された場合でも発動される
  @override
  void initState() {
    // addListenerして変更を感知
    _captionController.addListener(() {
      _onCaptionUpdated();
    });
    if(widget.from == PostCaptionOpenMode.FROM_FEED) {
      _captionController.text = widget.caption ?? "";
    }

    super.initState();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _captionController,
      style: postCaptionTextStyle,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "キャプション",
        border: InputBorder.none,
      ),
    );
  }

  _onCaptionUpdated() {
    if (widget.from == PostCaptionOpenMode.FROM_FEED) {
      final viewModel = context.read<FeedViewModel>();
      viewModel.caption = _captionController.text;
    } else {
      final viewModel = context.read<PostViewModel>();
      viewModel.caption = _captionController.text;
    }


  }
}
