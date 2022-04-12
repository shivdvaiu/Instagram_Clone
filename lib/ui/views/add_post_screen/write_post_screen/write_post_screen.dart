import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/models/user_model/user_model.dart';
import 'package:instagram_clone/business_logic/utils/services/dialogs/select_image_dialog/select_image_dialog.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/ui/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class WritePostScreen extends StatelessWidget {
  final VoidCallback onPostCallback;

  final UserModel userModel;
  final TextEditingController captionEditingController;
  final Uint8List postImage;

  WritePostScreen(
      {required this.onPostCallback,
      required,
      required this.userModel,
      required this.captionEditingController,
      required this.postImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userModel.photoUrl,
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPostCallback,
            child: Text(
              "Post",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          )
        ],
      ),
      // POST FORM
      body: Column(
        children: <Widget>[
          const Divider(),
          GestureDetector(
            onTap: () {},
            child: ClipOval(
              child: Container(
                height: 30.h,
                width: 30.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  alignment: FractionalOffset.topCenter,
                  image: MemoryImage(postImage),
                )),
              ),
            ),
          ),
          CustomTextField(
              hintText: Strings.writeCaption,
              textInputType: TextInputType.emailAddress,
              textEditingController: captionEditingController)
        ],
      ),
    );
  }
}
