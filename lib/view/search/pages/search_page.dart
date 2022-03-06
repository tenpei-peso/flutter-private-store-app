import 'package:flutter/material.dart';
import 'package:pesostagram/view/search/components/search_user_delegate.dart';

class SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        backgroundColor: Colors.green,
        title: InkWell(
          splashColor: Colors.white12,
          child: Text("友達を追加・検索"),
          onTap: () => _searchUser(context),
        ),
      ),
      body: Center(child: Text("友達を追加・検索"),),

    );
  }

  _searchUser(BuildContext context) async {
    final selectedUser = await showSearch(
        context: context,
        delegate: SearchUserDelegate()
    );
  }
}
