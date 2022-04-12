import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/services/dialogs/circular_progress_bar.dart';
import 'package:instagram_clone/business_logic/utils/services/dialogs/select_image_dialog/select_image_dialog.dart';
import 'package:instagram_clone/business_logic/utils/services/snack_bar/snack_bar.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/add_post_view_model/add_post_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/base_view_model/base_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:instagram_clone/ui/views/add_post_screen/write_post_screen/write_post_screen.dart';
import 'package:instagram_clone/ui/views/base_view/base_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPostViewModel>(
        builder: (BuildContext context, addPostProvider, Widget? child) =>
            addPostProvider.postImageFile == null
                ? Scaffold(
                  appBar: AppBar(backgroundColor: Colors.white),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    body: Center(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Select Image\nTo Post",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontSize: 12.sp),
                            ),
                            IconButton(
                                onPressed: () {
                                  selectImage(context, addPostProvider);
                                },
                                icon: Icon(
                                  Icons.upload_file,
                                  color: Theme.of(context).primaryColorDark,
                                  size: 30.sp,
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                : WritePostScreen(
                    onPostCallback: () {
                      showCircularProgressBar(context: context);
                      addPostProvider
                          .uploadPost(
                              addPostProvider.captionEditingController.text
                                  .trim(),
                              addPostProvider.postImageFile!,
                              context.read<HomeViewModel>().firebaseUser!.uid,
                              context
                                  .read<HomeViewModel>()
                                  .firebaseUser!
                                  .username,
                              context
                                  .read<HomeViewModel>()
                                  .firebaseUser!
                                  .photoUrl)
                          .then((postState) {
                        Navigator.pop(context);
                        Future.delayed(Duration(microseconds: 300));

                        switch (postState) {
                          case UploadPostState.POST_UPLOADED:
                            addPostProvider.clearPostInformation();
                            showSnackBar(context, Strings.postUploaded);
                            context.read<HomeViewModel>().changePage = 0;
                            Future.delayed(Duration(seconds: 2),(){
                              Navigator.pop(context);
                              context.read<BaseViewModel>().setCurrentBottomNavIndex = 0;
                            });
                            break;

                          case UploadPostState.UNKNOWN_ERROR:
                            showSnackBar(context, Strings.unknownError);
                            break;

                          default:
                        }
                      });
                    },
                    userModel: context.read<HomeViewModel>().firebaseUser!,
                    captionEditingController:
                        addPostProvider.captionEditingController,
                    postImage: addPostProvider.postImageFile!));
  }
}
