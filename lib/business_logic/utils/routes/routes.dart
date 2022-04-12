import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/views/add_post_screen/add_post_screen.dart';
import 'package:instagram_clone/ui/views/auth/login_screen.dart';
import 'package:instagram_clone/ui/views/auth/sign_up_screen.dart';
import 'package:instagram_clone/ui/views/base_view/base_view.dart';
import 'package:instagram_clone/ui/views/home_screen/home_view.dart';
import 'package:instagram_clone/ui/views/home_screen/post_card_view/comments_view/comments_view.dart';

class Routes {
  Routes._privateConstructor();

  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String homeScreen = '/home';
  static const String commentsScreen = '/comments';
  static const String addPost = "AddPostScreen";
static const String baseView = '/baseView';

  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    loginScreen: (_) => LoginScreen(),
    signupScreen: (_) => SignUpScreen(),
    homeScreen: (_) => HomeScreen(),
    commentsScreen: (_) => CommentsScreen(),
    addPost:(_)=>AddPostScreen(),
    baseView:(_)=>BaseView(),
  };
}
