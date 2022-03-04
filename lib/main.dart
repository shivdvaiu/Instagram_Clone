import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/routes/routes.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_service/database_service.dart';
import 'package:instagram_clone/business_logic/utils/services/firebase/firebase_methods.dart';
import 'package:instagram_clone/business_logic/view_models/auth/login_view_model.dart/login_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/auth/sign_up_view_model/sign_up_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/theme_view_model/theme_view_model.dart';
import 'package:instagram_clone/ui/app_theme/app_theme.dart';
import 'package:instagram_clone/ui/views/auth/login_screen.dart';
import 'package:instagram_clone/ui/views/home_screen/home_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'business_logic/view_models/add_post_view_model/add_post_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await Firebase.initializeApp();

  /// Checking if user is logged in or not
  bool isUserLoggedIn =
      StorageService().getFromDisk(DbKeys.isUserLoggedIn) ?? false;

  runApp(Sizer(
    builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(
            create: (_) => SignUpViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeViewModel(AppTheme.lightTheme),
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeViewModel(AppTheme.lightTheme),
          ),
          ChangeNotifierProvider(
            create: (_) => FirebaseMethods()..getFirebaseDeviceToken(),
          ),
          ChangeNotifierProvider(
              create: (_) => HomeViewModel()..fetchUserModel()),
          ChangeNotifierProvider(
            create: (BuildContext context) => AddPostViewModel(),
          )
        ],
        child: InstagramClone(
          isUserLoggedIn: isUserLoggedIn,
        ),
      );
    },
  ));
}

class InstagramClone extends StatelessWidget {
  final bool isUserLoggedIn;

  InstagramClone({required this.isUserLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
        builder: (context, themeProvider, child) => MaterialApp(
              routes: Routes.routes,
              debugShowCheckedModeBanner: false,
              theme: themeProvider.getTheme(),
              home: isUserLoggedIn == true ? HomeScreen() : LoginScreen(),
            ));
  }
}
