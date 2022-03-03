import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/routes/routes.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/view_models/auth/login_view_model.dart/login_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/auth/sign_up_view_model/sign_up_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/theme_view_model/theme_view_model.dart';
import 'package:instagram_clone/ui/app_theme/app_theme.dart';
import 'package:instagram_clone/ui/views/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await Firebase.initializeApp();


  
  runApp(Sizer(
    builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => SignUpViewModel()),
          ChangeNotifierProvider(
            create: (_) => ThemeViewModel(AppTheme.lightTheme),
          )
        ],
        child: InstagramClone(),
      );
    },
  ));
}

class InstagramClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
        builder: (context, themeProvider, child) => MaterialApp(
              initialRoute: Routes.loginScreen,
              routes: Routes.routes,
              debugShowCheckedModeBanner: false,
              theme: themeProvider.getTheme(),
              home: LoginScreen(),
            ));
  }
}
