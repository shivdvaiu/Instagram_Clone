import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/constants/constants.dart';
import 'package:instagram_clone/ui/widgets/custom_text_field.dart';
import 'package:instagram_clone/ui/widgets/dummy_users.dart';
import 'package:sizer/sizer.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            /// Chats and edit
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chats",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16.sp,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.4),
                              blurRadius: 3.0,
                              offset: Offset(1, 3)),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Theme.of(context).colorScheme.surface),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                color: Theme.of(context).colorScheme.surface,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
            _verticalSpace(),
            // CustomTextField(
            //   hintText: 'Search chat here',
            //   prefixIcon: Icon(
            //     Icons.search,
            //     color: Theme.of(context).colorScheme.surface,
            //     size: 30,
            //   ),
            //   textEditingController: TextEditingController(),
            //   textInputType: TextInputType.name,
            // ),
            _verticalSpace(),

            Text(
              "Quick Chat",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13.sp,
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                  fontWeight: FontWeight.w600),
            ),
            _verticalSpace(),
            DummyUsers(),

            Text(
              "Message",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13.sp,
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Constants.usersModel.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        child: Row(children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  "${Constants.usersModel[index].userNetworkImage}"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        Constants.usersModel[index].userName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 10.sp,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary.withOpacity(0.8),
                                                fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        Constants.usersModel[index].comment,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 10.sp,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary
                                                  .withOpacity(0.8),
                                            ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                index.isEven ? "just now" : "${index + 25} min",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 8.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer),
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Text(
                                      "${index + 1}",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 8.sp,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ]),
                        height: 10.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    );
                  }),
            ),
            _verticalSpace()
          ]),
        ),
      ),
    );
  }

  SizedBox _verticalSpace() => SizedBox(height: 20);
}
