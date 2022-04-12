import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/business_logic/utils/assets/assets.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/routes/routes.dart';
import 'package:instagram_clone/business_logic/utils/services/dialogs/circular_progress_bar.dart';
import 'package:instagram_clone/business_logic/utils/services/snack_bar/snack_bar.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/auth/login_view_model.dart/login_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/theme_view_model/theme_view_model.dart';
import 'package:instagram_clone/ui/app_theme/app_theme.dart';
import 'package:instagram_clone/ui/widgets/custom_text_field.dart';
import 'package:instagram_clone/ui/widgets/elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (BuildContext context, loginProvider, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
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
                    AssetsPath.instaLogo,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  CustomTextField(
                      hintText: Strings.emailHint,
                      textInputType: TextInputType.emailAddress,
                      textEditingController:
                          loginProvider.loginEmailEditingController),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                    hintText: Strings.passwordHint,
                    textInputType: TextInputType.text,
                    textEditingController:
                        loginProvider.loginPasswordEditingController,
                    isObsecure: true,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  MyElevatedButton(
                      onPressed: () {
                        if (loginProvider
                                .loginPasswordEditingController.text.isEmpty ||
                            loginProvider
                                .loginPasswordEditingController.text.isEmpty) {
                          showSnackBar(
                              context, Strings.fillRequiredInformation);
                          return;
                        }
                        showCircularProgressBar(context: context);
                        loginProvider
                            .signInWithEmailAndPassword(
                                email: loginProvider
                                    .loginEmailEditingController.text
                                    .trim(),
                                password: loginProvider
                                    .loginPasswordEditingController.text
                                    .trim())
                            .then((signInState) {
                          Navigator.pop(context);

                          switch (signInState) {
                            case SignInState.USER_NOT_FOUND:
                              showSnackBar(context, Strings.noEmailFound);
                              break;

                            case SignInState.UNKNOWN_ERROR:
                              showSnackBar(context, Strings.unknownError);
                              break;
                            case SignInState.WRONG_PASSWORD:
                              showSnackBar(context, Strings.wrongPassword);
                              break;
                            case SignInState.INVALID_EMAIL:
                              showSnackBar(context, Strings.invalidEmail);
                              break;
                            case SignInState.SIGN_IN_SUCCESS:
                              loginProvider.setUserLoggedIn();
                              Navigator.popAndPushNamed(
                                  context, Routes.homeScreen);
                              break;
                            default:
                          }
                        });
                      },
                      buttonName: Strings.loginText,
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.w,
                        vertical: 1.5.h,
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
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 12.sp, color: Colors.black)),
                  ])),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            showCircularProgressBar(context: context);

                            loginProvider.signInWithGoogle().then((value) {
                              Navigator.pop(context);
                              if (loginProvider.hasError == false) {
                                Navigator.popAndPushNamed(
                                    context, Routes.baseView);
                              } else if (loginProvider.hasError) {
                                showSnackBar(
                                    context, loginProvider.errorCode ?? "");
                              }
                            });
                          },
                          child: _roundedButton(AssetsPath.google)),
                      GestureDetector(
                          onTap: () {
                            showCircularProgressBar(context: context);

                            loginProvider.signInWithApple().then((value) {
                              Navigator.pop(context);
                              if (loginProvider.hasError == false) {
                                Navigator.popAndPushNamed(
                                    context, Routes.baseView);
                              } else if (loginProvider.hasError) {
                                showSnackBar(
                                    context, loginProvider.errorCode ?? "");
                              }
                            });
                          },
                          child: _roundedButton(AssetsPath.apple)),
                      GestureDetector(
                          onTap: () async {
                            showCircularProgressBar(context: context);

                            loginProvider.signInwithFacebook().then((value) {
                              Navigator.pop(context);
                              if (loginProvider.hasError == false) {
                                Navigator.popAndPushNamed(
                                    context, Routes.baseView);
                              } else if (loginProvider.hasError) {
                                showSnackBar(
                                    context, loginProvider.errorCode ?? "");
                              }
                            });
                          },
                          child: _roundedButton(AssetsPath.facebook))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _roundedButton(String path) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Color(0xffeaefff),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          path,
          height: 30,
        ),
      ),
    );
  }
}
