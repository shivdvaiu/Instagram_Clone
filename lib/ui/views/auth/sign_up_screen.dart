import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/business_logic/utils/assets/assets.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/services/dialogs/circular_dialog.dart';
import 'package:instagram_clone/business_logic/utils/services/material_banner/material_banner.dart';
import 'package:instagram_clone/business_logic/utils/services/snack_bar/snack_bar.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/auth/login_view_model.dart/login_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/auth/sign_up_view_model/sign_up_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/theme_view_model/theme_view_model.dart';
import 'package:instagram_clone/ui/app_theme/app_theme.dart';
import 'package:instagram_clone/ui/views/base_view/base_view.dart';
import 'package:instagram_clone/ui/widgets/custom_text_field.dart';
import 'package:instagram_clone/ui/widgets/elevated_button.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final SignUpViewModel signUpProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpProvider = context.read<SignUpViewModel>();

   log( signUpProvider.userNameController.text);
  
  }


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

   log( signUpProvider.userNameController.text);
  }




  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      builder: (BuildContext, signUpProvider, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  SvgPicture.asset(
                    Assets.instaLogo,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  signUpProvider.image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(signUpProvider.image!),
                          backgroundColor: Colors.red,
                        )
                      : Stack(
                          children: [
                            const CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  NetworkImage(Strings.placeHolderUserImage),
                              backgroundColor: Colors.grey,
                            ),
                            Positioned(
                              bottom: -10,
                              left: 80,
                              child: IconButton(
                                onPressed: () {
                                  signUpProvider.selectImage();
                                },
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            )
                          ],
                        ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                    hintText: Strings.userName,
                    textInputType: TextInputType.name,
                    textEditingController: signUpProvider.userNameController,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                    hintText: Strings.emailHint,
                    textInputType: TextInputType.text,
                    textEditingController: signUpProvider.emailController,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                    hintText: Strings.passwordHint,
                    textInputType: TextInputType.text,
                    textEditingController: signUpProvider.passwordController,
                    isObsecure: true,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                    hintText: Strings.confirmHint,
                    textInputType: TextInputType.text,
                    textEditingController:
                        signUpProvider.passwordConfirmController,
                    isObsecure: true,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                    hintText: Strings.userBio,
                    textInputType: TextInputType.text,
                    textEditingController: signUpProvider.bioController,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  MyElevatedButton(
                      onPressed: () {
                        if (signUpProvider.image == null) {
                          showSnackBar(context, "Please Select Image");
                          return;
                        }

                        showCustomDialog(context: context);

                        if (signUpProvider.passwordController.text !=
                            signUpProvider.passwordConfirmController.text) {
                          return;
                        }

                        createUser(
                            context: context, signUpProvider: signUpProvider);
                      },
                      buttonName: Strings.signupText,
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
                        text: Strings.alreadyHaveAccount,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 12.sp)),
                    TextSpan(text: '  '),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                        text: Strings.loginText,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 12.sp,
                            color: Theme.of(context).colorScheme.secondary))
                  ])),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  createUser(
      {required BuildContext context,
      required SignUpViewModel signUpProvider}) {
    signUpProvider
        .signUpUserUsingFirebase(
            bio: signUpProvider.bioController.text,
            email: signUpProvider.emailController.text,
            password: signUpProvider.passwordController.text,
            username: signUpProvider.userNameController.text)
        .then((signUpState) {
      Navigator.pop(context);
      switch (signUpState) {
        case SignUpState.ALREADY_HAVE_ACCOUNT:
          showSnackBar(context, Strings.alreadyHaveAccountError);
          break;
        case SignUpState.WEAK_PASSWORD:
          showSnackBar(context, Strings.weakPassword);
          break;

        case SignUpState.UNKNOWN_ERROR:
          showSnackBar(context, Strings.unknownError);
          break;

        case SignUpState.SIGN_UP_SUCCESS:
          showSnackBar(context, Strings.signUpSucceed);
      }
    });
  }
}
