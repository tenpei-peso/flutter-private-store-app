import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pesostagram/di/providers.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/view/home_screen.dart';
import 'package:pesostagram/view/login/screens/login_screen.dart';
import 'package:pesostagram/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:timeago/timeago.dart' as timeAgo;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  timeAgo.setLocaleMessages("ja", timeAgo.JaMessages());
  
  runApp(
      MultiProvider(
        providers: globalProviders,
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

    return MaterialApp(
      title: "Pesostagram",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Colors.white,
        )),
        primaryIconTheme: IconThemeData(color: Colors.blue),
        iconTheme: IconThemeData(color: Colors.black38),
        fontFamily: RegularFont,
      ),
      home: FutureBuilder(
        //ログインしていればHomeScreenでしてなかったらLoginScreenにいく
        future: loginViewModel.isSingIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
