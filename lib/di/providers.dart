import 'package:flutter/material.dart';
import 'package:pesostagram/models/db/database_manager.dart';
import 'package:pesostagram/models/location/location_manager.dart';
import 'package:pesostagram/models/repositories/post_repository.dart';
import 'package:pesostagram/models/repositories/user_repository.dart';
import 'package:pesostagram/view_models/login_view_model.dart';
import 'package:pesostagram/view_models/post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../view_models/comments_view_model.dart';
import '../view_models/feed_view_model.dart';
import '../view_models/profile_view_model.dart';
import '../view_models/search_view_model.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
      create: (context) => DatabaseManager()
  ),
  Provider<LocationManager>(
      create: (context) => LocationManager()
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (context, dbManager, repo) => UserRepository(dbManager: dbManager),
  ),

  ProxyProvider2<DatabaseManager, LocationManager ,PostRepository>(
      update: (context, dmManager, locationManager, repo) => PostRepository(
        dbManager: dmManager,
        locationManager: locationManager
      ),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(
          userRepository: Provider.of<UserRepository>(context, listen: false)
      ),
  ),
  ChangeNotifierProvider<PostViewModel>(
    create: (context) => PostViewModel(
      userRepository: context.read<UserRepository>(),
      postRepository: context.read<PostRepository>(),
    ),
  ),
  ChangeNotifierProvider<FeedViewModel>(
    create: (context) => FeedViewModel(
      userRepository: context.read<UserRepository>(),
      postRepository: context.read<PostRepository>(),
    ),
  ),
  ChangeNotifierProvider<CommentsViewModel>(
    create: (context) => CommentsViewModel(
      userRepository: context.read<UserRepository>(),
      postRepository: context.read<PostRepository>(),
    ),
  ),
  ChangeNotifierProvider<ProfileViewModel>(
    create: (context) => ProfileViewModel(
      userRepository: context.read<UserRepository>(),
      postRepository: context.read<PostRepository>(),
    ),
  ),
  ChangeNotifierProvider<SearchViewModel>(
    create: (context) => SearchViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
];