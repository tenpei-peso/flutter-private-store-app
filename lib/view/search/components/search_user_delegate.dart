import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';
import 'package:pesostagram/view/common/components/user_card.dart';
import 'package:pesostagram/view/profile/screens/profile_screen.dart';
import 'package:pesostagram/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

import '../../../deta_models/user.dart';

class SearchUserDelegate extends SearchDelegate<User?> {
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => {
            query = ""
          },
          icon: Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchViewModel = context.read<SearchViewModel>();
    searchViewModel.searchUsers(query);
    return _buildResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchViewModel = context.read<SearchViewModel>();
    searchViewModel.searchUsers(query);
    return _buildResults(context);
  }

  Widget _buildResults(BuildContext context) {
    return Consumer<SearchViewModel>(
        builder: (context, model, child) {
          return ListView.builder(
              itemCount: model.soughtUsers.length,
              itemBuilder: (context, int index) {
                final user = model.soughtUsers[index];
                return UserCard(
                    photoUrl: user.photoUrl,
                    title: user.inAppUserName,
                    subTitle: user.bio,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ProfileScreen(profileMode: ProfileMode.OTHER, selectedUser: user,)
                      ));
                    },
                );
              }
          );
        }
    );
  }

}
