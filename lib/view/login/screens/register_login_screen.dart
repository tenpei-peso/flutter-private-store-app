
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

import '../../../style.dart';
import '../../home_screen.dart';

class registerLoginScreen extends StatelessWidget {
  final emailOpenMode loginType;

  const registerLoginScreen({required this.loginType});

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";

    final GlobalKey<FormState> _key = GlobalKey<FormState>();

    return Scaffold(
      body: Center(
        child: Consumer<LoginViewModel>(
          builder: (BuildContext context, model, Widget? child) {
            return model.emailIsLoading
            ? CircularProgressIndicator()
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (loginType == emailOpenMode.EMAIL_REGISTER)
                ? Text("新規登録")
                : Text("ログイン"),

                Form(
                  key: _key,
                  child: Container(
                    width: 300,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'メールアドレス',
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if ((value == null) || !EmailValidator.validate(value)) {
                              return 'Emailが不正です';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        SizedBox(height: 6.0,),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'パスワード'),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 5 || value.length > 13) {
                              return 'パスワードを正しく入力してください';
                            }
                            return null;
                          }, // 追加
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        ElevatedButton(
                            onPressed: () => emailLogin(context, email, password, _key),
                            child: Text("送信", style: buttonTextColor)
                        ),
                      ],
                    ),
                  ),
                )

              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> emailLogin(BuildContext context, email, password, _key) async {
    if (!_key.currentState!.validate()) return; //バリデーション

    final viewModel = Provider.of<LoginViewModel>(context, listen: false);
    viewModel.emailString = email;
    viewModel.passwordString = password;

    if(loginType == emailOpenMode.EMAIL_REGISTER) {
      await viewModel.emailRegister();
    } else {
      await viewModel.emailSignIn();
    }
    if (!viewModel.emailIsSuccessful) {
      Fluttertoast.showToast(msg: "ログインに失敗しました。もう一度お試しください");
      return;
    }
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => HomeScreen()
    )
    );

  }
}
