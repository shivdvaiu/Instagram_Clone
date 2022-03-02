import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/routes/routes.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/ui/views/auth/login_screen.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await Firebase.initializeApp();

  runApp(Sizer(
    builder: (context, orientation, deviceType) {
      return MaterialApp(
        initialRoute: Routes.loginScreen,
        routes: Routes.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: LoginScreen(),
      );
    },
  ));
}


