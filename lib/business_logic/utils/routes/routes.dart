import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/views/auth/login_screen.dart';
import 'package:instagram_clone/ui/views/auth/sign_up_screen.dart';
import 'package:instagram_clone/ui/views/home_screen/home_view.dart';

class Routes {
  Routes._privateConstructor();

  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String homeScreen = '/home';

  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    loginScreen: (_) => LoginScreen(),
    signupScreen: (_) => SignUpScreen(),
homeScreen:(_)=>HomeScreen(),
  };
}
