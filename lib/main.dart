import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:instagram_clone/business_logic/utils/routes/routes.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_service/database_service.dart';
import 'package:instagram_clone/business_logic/utils/services/firebase/firebase_methods.dart';
import 'package:instagram_clone/business_logic/utils/services/push_notifications/firebase_notification.dart';
import 'package:instagram_clone/business_logic/view_models/auth/login_view_model.dart/login_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/auth/sign_up_view_model/sign_up_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/base_view_model/base_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/post_view_model/post_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/theme_view_model/theme_view_model.dart';
import 'package:instagram_clone/ui/app_theme/app_theme.dart';
import 'package:instagram_clone/ui/views/auth/login_screen.dart';
import 'package:instagram_clone/ui/views/base_view/base_view.dart';
import 'package:instagram_clone/ui/views/home_screen/home_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'business_logic/view_models/add_post_view_model/add_post_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();


if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAjsBwtHe5o06biXBK6p8CU33ADF9KaHT4",
            appId: "1:282255248544:ios:e88cd29a3f17a2b12acdc5",
            messagingSenderId: "282255248544",
            projectId: "instagramclone-db171"));
  } else {
    await Firebase.initializeApp();
  }


  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMethods().getFirebaseDeviceToken();

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
            create: (_) => ThemeViewModel(),
          ),
          ChangeNotifierProvider(create: (_) => FirebaseMethods()),
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
          ChangeNotifierProvider(
            create: (BuildContext context) => AddPostViewModel(),
          ),
          ChangeNotifierProvider(
              create: (BuildContext context) => PostViewModel()),
          ChangeNotifierProvider(create: (_) => BaseViewModel()),
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
    return MaterialApp(
      theme: primaryMaterialTheme,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
      home: isUserLoggedIn == true ? BaseView() : LoginScreen(),
    );
  }
}
