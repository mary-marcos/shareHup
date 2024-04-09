import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:share_meal/models/product.dart';
import 'package:share_meal/models/user.dart';

class Productitem extends StatelessWidget {
  Productitem({
    required this.theUser,
    required this.myproduct,
    super.key,
  });
  Product myproduct;
  User_m theUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/ItemDetails',
              arguments: {'theUser': theUser, "myproduct": myproduct});
        },
        child: Card(
            elevation: 7,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: NetworkImage(myproduct.img1))),
                  width: 90.w,
                  height: 90.h,
                ),
                Column(
                  children: [
                    Text(
                      myproduct.product_name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: black),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/Profile',
                                arguments: {
                                  'theUser': theUser,
                                });
                          },
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundImage: NetworkImage(
                              theUser.userimg,
                            ),
                          ),
                        ),
                        Text(
                          theUser.username,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: yello,
                        ),
                        Text(
                          "4.5",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: black),
                        )
                      ],
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
