import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/activities/pages/activities_page.dart';
import 'package:pesostagram/view/feed/pages/feed_page.dart';
import 'package:pesostagram/view/post/pages/post_page.dart';
import 'package:pesostagram/view/profile/pages/profile_page.dart';
import 'package:pesostagram/view/search/pages/search_page.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages = [];
  int _currentIndex = 0;

  @override
  void initState() {
    _pages = [
      FeedPage(),
      PostPage(),
      ActivitiesPage(),
      ProfilePage(profileMode: ProfileMode.MYSELF,),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home, color: Colors.green,),
              label: "ホーム",
          ),
          // BottomNavigationBarItem(
          //     icon: FaIcon(FontAwesomeIcons.map, color: Colors.green),
          //     label: "マップ",
          // ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.plusSquare, color: Colors.green),
              label: "投稿",
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.heart, color: Colors.green),
              label: "アクティビティ",
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user, color: Colors.green),
              label: "ユーザー",
          ),
        ],
      ),
    );
  }
}
