import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/view/common/components/button_with_icon.dart';
import 'package:pesostagram/view/home_screen.dart';
import 'package:pesostagram/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Consumer<LoginViewModel>(
            builder: (BuildContext context, model, Widget? child) {
              return model.isLoading
              ? CircularProgressIndicator()
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pesostagram", style: loginTitleTextStyle,),
                  SizedBox(height: 8.0,),
                  ButtonWithIcon(
                    iconData: FontAwesomeIcons.signInAlt,
                    label: "サインイン",
                    onPressed: () => login(context),
                  ),
                ],
              );
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

  void _openHomeScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => HomeScreen()
    )
    );
  }
}
