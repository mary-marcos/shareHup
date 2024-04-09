//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_meal/Blogic/firebase/auth.dart';
import 'package:share_meal/Blogic/firebase/firestore.dart';
import 'package:share_meal/constants/buttons.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:share_meal/models/product.dart';
import 'package:share_meal/models/user.dart';
import 'package:share_meal/widgets/product_item.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Profile extends StatefulWidget {
  Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

@override
class _ProfileState extends State<Profile> {
  @override
  late User_m the_user;
  /*void initState() {
    super.initState();
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    the_user = args?['theUser'];
  }*/
  Map<String, dynamic>? args = null;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      the_user = args?['theUser'];
    }
    if (args == null) {
      initializeState();
    }
  }

  Future<void> initializeState() async {
    try {
      await getuser();
    } catch (e) {
      print('Error initializing state: $e');
    } finally {
      setState(() {});
    }
  }

  Future<void> getuser() async {
    the_user = await FireStore.getCurrent();
    if (the_user != null) {}
    setState(() {});
  }

  bool enable_sells = false;
  bool enable_free = true;
  bool enable_lend = false;
  bool enable_needs = false;
  @override
  Widget build(BuildContext context) {
    if (the_user == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: args == null ? Text("my profile") : Text(the_user.username),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).cardColor,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundImage: NetworkImage(the_user.userimg),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        children: [
                          Text(
                            the_user.username,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context).selectedRowColor,
                                    fontWeight: FontWeight.w900),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: grey,
                              ),
                              Text(
                                the_user.location,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 13.sp,
                                        color: grey,
                                        fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: yello,
                              ),
                              Icon(
                                Icons.star,
                                color: yello,
                              ),
                              Icon(
                                Icons.star,
                                color: yello,
                              ),
                              Text(
                                "5.0",
                                style: TextStyle(color: black),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).selectedRowColor,
                  width: 250.w,
                  height: 2.h,
                  //color: grey,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Theme.of(context).cardColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EnableButton(
                          backgroundColor: enable_free ? green : grey,
                          ch: Text("مجانى"),
                          onPress: () {
                            setState(() {
                              enable_free = true;
                              enable_sells = false;
                              enable_lend = false;
                              enable_needs = false;
                            });
                          },
                        ),
                        EnableButton(
                          backgroundColor: enable_sells ? green : grey,
                          ch: Text("شراء"),
                          onPress: () {
                            setState(() {
                              enable_free = false;
                              enable_sells = true;
                              enable_lend = false;
                              enable_needs = false;
                            });
                          },
                        ),
                        EnableButton(
                          backgroundColor: enable_lend ? green : grey,
                          ch: Text("استعاره"),
                          onPress: () {
                            setState(() {
                              enable_free = false;
                              enable_sells = false;
                              enable_lend = true;
                              enable_needs = false;
                            });
                          },
                        ),
                        EnableButton(
                          backgroundColor: enable_needs ? green : grey,
                          ch: Text("احتياجات"),
                          onPress: () {
                            setState(() {
                              enable_free = false;
                              enable_sells = false;
                              enable_lend = false;
                              enable_needs = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).cardColor,
                  height: 365.5.h,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("User")
                        .where("userID", isEqualTo: the_user.userID)
                        .snapshots(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: userSnapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int userIndex) {
                            // Extract user data
                            String userID =
                                userSnapshot.data!.docs[userIndex]["userID"];
                            String fullName =
                                userSnapshot.data!.docs[userIndex]["fullname"];
                            String gender =
                                userSnapshot.data!.docs[userIndex]["Gender"];
                            String location =
                                userSnapshot.data!.docs[userIndex]["location"];
                            String phoneNumber = userSnapshot
                                .data!.docs[userIndex]["phoneNumber"];
                            String username =
                                userSnapshot.data!.docs[userIndex]["userName"];
                            String userImg =
                                userSnapshot.data!.docs[userIndex]["userimg"];

                            // Create User_m object
                            User_m userData = User_m(
                              userID: userID,
                              fullName: fullName,
                              Gender: gender,
                              location: location,
                              phonenumber: phoneNumber,
                              username: username,
                              userimg: userImg,
                            );

                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("User")
                                  .doc(userSnapshot.data!.docs[userIndex].id)
                                  .collection(enable_free
                                      ? "freenonfood"
                                      : enable_sells
                                          ? "Sells_sprod"
                                          : enable_lend
                                              ? "Borrowprod"
                                              : "Wanted")
                                  .snapshots(),
                              builder: (context, subSnapshot) {
                                if (subSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else {
                                  // Create list of Product objects
                                  List<Product> products = [];
                                  for (int i = 0;
                                      i < subSnapshot.data!.docs.length;
                                      i++) {
                                    // Extract product data
                                    String productName = subSnapshot
                                        .data!.docs[i]["product_name"];
                                    String img1 =
                                        subSnapshot.data!.docs[i]["img1"];
                                    String city =
                                        subSnapshot.data!.docs[i]["city"];
                                    String userProfileImg = subSnapshot
                                        .data!.docs[i]["user_profile_img"];
                                    String productUsername =
                                        subSnapshot.data!.docs[i]["username"];
                                    String info =
                                        subSnapshot.data!.docs[i]["info"];

                                    String productId =
                                        subSnapshot.data!.docs[i]["productId"];

                                    Product productData = Product(
                                      productId: productId,
                                      product_name: productName,
                                      img1: img1,
                                      city: city,
                                      user_profile_img: userProfileImg,
                                      username: productUsername,
                                      info: info,
                                    );

                                    enable_free
                                        ? productData = FreeProduct(
                                            productId: productId,
                                            product_name: productName,
                                            img1: img1,
                                            city: city,
                                            user_profile_img: userProfileImg,
                                            username: productUsername,
                                            info: info,
                                          )
                                        : enable_sells
                                            ? productData = selle_prod(
                                                prodPrice: subSnapshot
                                                    .data!.docs[i]["prodPrice"],
                                                productId: productId,
                                                product_name: productName,
                                                img1: img1,
                                                city: city,
                                                user_profile_img:
                                                    userProfileImg,
                                                username: productUsername,
                                                info: info,
                                              )
                                            : enable_lend
                                                ? productData = BorrowProduct(
                                                    days: subSnapshot
                                                        .data!.docs[i]["days"],
                                                    prodPrice: subSnapshot.data!
                                                        .docs[i]["prodPrice"],
                                                    productId: productId,
                                                    product_name: productName,
                                                    img1: img1,
                                                    city: city,
                                                    user_profile_img:
                                                        userProfileImg,
                                                    username: productUsername,
                                                    info: info,
                                                  )
                                                : productData = Wanted(
                                                    productId: productId,
                                                    product_name: productName,
                                                    img1: img1,
                                                    city: city,
                                                    user_profile_img:
                                                        userProfileImg,
                                                    username: productUsername,
                                                    info: info,
                                                  );

                                    // Create Product object

                                    // Add product to the list
                                    products.add(productData);
                                  }

                                  // Set the list of products in the User_m object
                                  userData.aproduct = products;

                                  return products.length != 0
                                      ? Container(
                                          // height: 250.h,
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: products.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Dismissible(
                                                background: Container(
                                                  decoration: BoxDecoration(
                                                      color: red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.r)),
                                                  margin: EdgeInsets.only(
                                                    bottom: 10.h,
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    bottom: 8.h,
                                                  ),
                                                ),
                                                direction: args == null
                                                    ? DismissDirection
                                                        .horizontal
                                                    : DismissDirection
                                                        .none, //args == null ? DismissDirection.none : null,

                                                onDismissed: args == null
                                                    ? (direction) {
                                                        deleteItem(
                                                            userSnapshot
                                                                .data!
                                                                .docs[userIndex]
                                                                .id,
                                                            products[index]
                                                                .productId);
                                                      }
                                                    : null,
                                                key: ValueKey(index),
                                                child: Productitem(
                                                  theUser: userData,
                                                  myproduct: products[index],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Container(
                                          // height: 1.h,
                                          color: red,
                                        );
                                }
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ]),
        ),
      ),
    );
  }

  Future<void> deleteItem(String userId, String productId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("User")
          .doc(userId)
          .collection(enable_free
              ? "freenonfood"
              : enable_sells
                  ? "Sells_sprod"
                  : enable_lend
                      ? "Borrowprod"
                      : "Wanted")
          .where("productId", isEqualTo: productId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the document to delete
        DocumentReference docRef = querySnapshot.docs.first.reference;

        // Delete the document
        await docRef.delete();
        print("Item deleted successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم محو العنصر بنجاح'),
          ),
        );
      } else {
        print("No matching document found with productId: $productId");
      }
    } catch (error) {
      print("Error deleting item: $error");
    }
  }
}
