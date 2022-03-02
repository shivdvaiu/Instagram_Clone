import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/business_logic/utils/assets/assets.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/auth/login_view_model.dart/login_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/auth/sign_up_view_model/sign_up_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/theme_view_model/theme_view_model.dart';
import 'package:instagram_clone/ui/app_theme/app_theme.dart';
import 'package:instagram_clone/ui/widgets/custom_text_field.dart';
import 'package:instagram_clone/ui/widgets/elevated_button.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpProvider = context.read<SignUpViewModel>();

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
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                      shape: BoxShape.circle),
                  height: 80,
                  width: 80,
                  child:Icon(Icons.verified_user)),
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
                isPass: true,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextField(
                hintText: Strings.passwordHint,
                textInputType: TextInputType.text,
                textEditingController: signUpProvider.passwordController,
                isPass: true,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextField(
                hintText: Strings.confirmHint,
                textInputType: TextInputType.text,
                textEditingController: signUpProvider.passwordConfirmController,
                isPass: true,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextField(
                hintText: Strings.userBio,
                textInputType: TextInputType.text,
                textEditingController: signUpProvider.bioController,
                isPass: true,
              ),
              SizedBox(
                height: 2.h,
              ),
              MyElevatedButton(
                  onPressed: () {
                    context.read<ThemeViewModel>().changeTheme();
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
  }
}
