import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/business_logic/utils/assets/assets.dart';
import 'package:instagram_clone/business_logic/utils/routes/routes.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/auth/login_view_model.dart/login_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/theme_view_model/theme_view_model.dart';
import 'package:instagram_clone/ui/app_theme/app_theme.dart';
import 'package:instagram_clone/ui/widgets/custom_text_field.dart';
import 'package:instagram_clone/ui/widgets/elevated_button.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<LoginViewModel>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              SvgPicture.asset(
                Assets.instaLogo,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(
                height: 4.h,
              ),
              CustomTextField(
                hintText: Strings.emailHint,
                textInputType: TextInputType.emailAddress,
                textEditingController: loginProvider.loginTextEditingController,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextField(
                hintText: Strings.passwordHint,
                textInputType: TextInputType.text,
                textEditingController:
                    loginProvider.loginPasswordEditingController,
                isPass: true,
              ),
              SizedBox(
                height: 3.h,
              ),
              MyElevatedButton(
                  onPressed: () {
                    context.read<ThemeViewModel>().changeTheme();
                  },
                  buttonName: Strings.loginText,
                  padding: EdgeInsets.symmetric(
                    horizontal: 36.w,
                    vertical: 1.h,
                  )),
              SizedBox(
                height: 3.h,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: Strings.dontHaveAccount,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 12.sp)),
                TextSpan(text: '  '),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, Routes.signupScreen);
                      },
                    text: Strings.signupText,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 12.sp,
                        color: Theme.of(context).colorScheme.secondary))
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
