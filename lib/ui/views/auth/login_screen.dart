import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/business_logic/utils/assets/assets.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/ui/widgets/custom_text_field.dart';
import 'package:instagram_clone/ui/widgets/elevated_button.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h,),
              SvgPicture.asset(
                Assets.instaLogo,
              ),
              SizedBox(
                height: 4.h,
              ),
              CustomTextField(
                hintText: Strings.emailHint,
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextField(
                hintText: Strings.passwordHint,
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              SizedBox(
                height: 3.h,
              ),
              MyElevatedButton(
                  onPressed: () {},
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
                    style: Theme.of(context).textTheme.bodyText1),
                TextSpan(text: '  '),
                TextSpan(
                    text: Strings.signupText,
                    style: Theme.of(context).textTheme.bodyText1)
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
