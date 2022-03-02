import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/views/auth/login_screen.dart';

class Routes{


Routes._privateConstructor();


static const String loginScreen = '/login';
 
static Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{

loginScreen:(_)=>LoginScreen()



};


   
}