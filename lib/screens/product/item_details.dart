import 'dart:developer';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_meal/constants/constans.dart';

//import 'package:satbark/models/cartproduct.dart';
//import 'package:satbark/models/produc_model.dart';
//import 'package:satbark/widgets/buttons.dart';
import 'package:flutter/foundation.dart';
//import 'package:satbark/businesslogic/firebase/fireStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_meal/constants/buttons.dart';
import 'package:share_meal/models/product.dart';
import 'package:share_meal/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetails extends StatefulWidget {
  ItemDetails({
    super.key,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

void _launchWhatsAppChat() async {
  //+201271427768
  String url =
      'https://wa.me/${theUser.phonenumber}/?text=  مرحبا احتاج ان اسال عن منتج ${myproduct.product_name}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw '====================Could not launch $url';
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          content: Text(
            'ارسال رسالع عبر  WhatsApp',
            style: TextStyle(color: black, fontSize: 17.sp),
          ),
          actions: [
            Button(
              ch: Icon(
                FontAwesomeIcons.whatsapp,
              ),

              // FontAwesomeIcons.whatsapp,
              onPress: () {
                _launchWhatsAppChat();
                // Action for the camera button
                //await
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      });
}

late Product myproduct;
late User_m theUser;
late String Product_type;

class _ItemDetailsState extends State<ItemDetails> {
  // late String? backimg;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    myproduct = args?['myproduct'];
    theUser = args?['theUser'];

    switch (myproduct.runtimeType) {
      case Wanted:
        Product_type = "Wanted";
        break;
      case FreeProduct:
        Product_type = "FreeProduct";
        break;
      case BorrowProduct:
        Product_type = "BorrowProduct";
        break;
      case selle_prod:
        Product_type = "selle_prod";
        break;
      default:
        Product_type = "Unknown";
    }

    // currentproduct = myprod;
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          myproduct.product_name,
          style: TextStyle(color: green, fontSize: 25.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).cardColor,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: MediaQuery.sizeOf(context).width,
                height: 230.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: green,
                    image: DecorationImage(image: NetworkImage(//backimg!
                        myproduct.img1), fit: BoxFit.cover)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Product_type == "BorrowProduct" ||
                            Product_type == "selle_prod"
                        ? Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(10),
                            color: grey,
                            child: Text("${myproduct.prodPrice}\E"))
                        : SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10.w, left: 10.w),
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(myproduct.user_profile_img),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${myproduct.username}  ",
                            style: TextStyle(color: black),
                          ),
                          Product_type == "Wanted"
                              ? Text(
                                  "يحتاج ",
                                  style: TextStyle(color: red),
                                )
                              : Product_type == "FreeProduct"
                                  ? Text(
                                      "يعطى مجانا ",
                                      style: TextStyle(color: red),
                                    )
                                  : Product_type == "BorrowProduct"
                                      ? Text(
                                          "يُقرِض ",
                                          style: TextStyle(color: red),
                                        )
                                      : Text(
                                          "يبيع ",
                                          style: TextStyle(color: red),
                                        ),
                        ],
                      ),
                      Text(
                        myproduct.product_name,
                        style: TextStyle(color: green, fontSize: 25.sp),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /* productImages(myprod.img1!),
                  productImages(myprod.img2!),
                  productImages(myprod.img3!),*/
                ],
              ),
              // Text("${myprod.name} ..${myprod.details} "   ),
              //  Text("${myprod.prodPrice}\$"),
              Product_type == "BorrowProduct"
                  ? Text(
                      " الاستلاف لمده ${myproduct.days} ايام",
                      style: TextStyle(color: black),
                    )
                  : SizedBox(),
              Text(
                "${myproduct.info} ",
                style: TextStyle(color: black),
              ),

              SizedBox(
                height: 5.h,
              ),

              // add to cart
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Button(
                        ch: Product_type == "Wanted"
                            ? Text("Help ${myproduct.username}")
                            : Text("Request"),
                        onPress: () {
                          _showAlertDialog(context);

                          // Navigator.pushNamed(context, '/WhatsAppChatIcon',
                          //   arguments: {"phoneNumber": theUser.phonenumber});
                          /*
                          listcartproduct.add(CartProduct(
                              img1: myprod.img1!,
                              counts: count,
                              name: myprod.name!,
                              prodPrice: myprod.prodPrice!,
                              totalPrice: count * myprod.prodPrice!));
                          print(listcartproduct);
                          */
                        }),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector productImages(String img) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // backimg = img;
        });
      },
      child: Container(
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
            border: Border.all(color: red, width: 4),
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: green,
            image: DecorationImage(image: NetworkImage(img))),
      ),
    );
  }
}
