import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/constants/constants.dart';
import 'package:sizer/sizer.dart';

class DummyUsers extends StatelessWidget {
  const DummyUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: Constants.usersModelTwo.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        child: Image.network(
                          Constants.usersModelTwo[index].userNetworkImage,
                          fit: BoxFit.cover,
                        ),
                           height:60,
                  width: 60,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      Constants.usersModelTwo[index].userName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                              fontSize: 8.sp,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.7),
                              fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 40,
                  right: 0,
                  child: ClipOval(
                    child: Container(
                      height: 12,
                      width: 12,
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
