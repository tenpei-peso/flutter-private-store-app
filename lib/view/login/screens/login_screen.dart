import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/common/components/button_with_icon.dart';
import 'package:pesostagram/view/home_screen.dart';
import 'package:pesostagram/view/login/screens/register_login_screen.dart';
import 'package:pesostagram/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Consumer<LoginViewModel>(
            builder: (BuildContext context, model, Widget? child) {
              if (model.isLoading) {
                return CircularProgressIndicator();
              } else {
                return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pesostagram", style: loginTitleTextStyle,),
                  SizedBox(height: 8.0,),
                  ButtonWithIcon(
                    iconData: FontAwesomeIcons.google,
                    label: "googleサインイン",
                    onPressed: () => login(context),
                  ),
                  SizedBox(height: 5.0,),
                  ButtonWithIcon(
                    iconData: FontAwesomeIcons.envelope,
                    label: "email新規登録",
                    onPressed: () => emailRegister(context, emailOpenMode.EMAIL_REGISTER),
                  ),
                  SizedBox(height: 5.0,),
                  ButtonWithIcon(
                      iconData: FontAwesomeIcons.signInAlt,
                      label: "emailサインイン",
                    onPressed: () => emailLogin(context, emailOpenMode.EMAIL_LOGIN),
                  ),
                ],
              );
              }
            },
          ),
        )
    );
  }

  Future<void> login(BuildContext context) async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    await loginViewModel.signIn();
    if (!loginViewModel.isSuccessful) {
      Fluttertoast.showToast(msg: "ログインに失敗しました。もう一度お試しください");
      return;
    }
    _openHomeScreen(context);
  }

  void emailLogin(BuildContext context, emailOpenMode email_login) {
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => registerLoginScreen(loginType: email_login,)
    )
    );
  }

  void emailRegister(BuildContext context, emailOpenMode email_register) {
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => registerLoginScreen(loginType: email_register,)
    )
    );
  }

  void _openHomeScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => HomeScreen()
    )
    );
  }


}
