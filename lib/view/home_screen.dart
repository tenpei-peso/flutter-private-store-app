import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/activities/pages/activities_page.dart';
import 'package:pesostagram/view/feed/pages/feed_page.dart';
import 'package:pesostagram/view/map/pages/map_page.dart';
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
      MapPage(),
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
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: Colors.green,
        backgroundColor: Colors.transparent,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          Icon(Icons.home, size: 30, color: Colors.white,),
          Icon(Icons.location_on, size: 30, color: Colors.white,),
          Icon(Icons.add, size: 30, color: Colors.white,),
          Icon(Icons.favorite, size: 30, color: Colors.white,),
          Icon(Icons.account_circle, size: 30, color: Colors.white,),
        ],
      ),
    );
  }
}
