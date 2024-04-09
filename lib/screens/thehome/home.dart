import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_meal/Blogic/firebase/auth.dart';
import 'package:share_meal/constants/buttons.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:share_meal/models/product.dart';
import 'package:share_meal/models/user.dart';
import 'package:share_meal/theme/theme_provider.dart';
import 'package:share_meal/widgets/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.curuser});
  User_m curuser;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isfood = true;
  bool enable_sells = false;
  bool enable_free = true;
  bool enable_lend = false;
  bool enable_needs = false;

  bool isdark = false;
  final auth = FirebaseAuth.instance;
  List<String> Locations = [
    "القاهره",
    "الاقصر",
    "المنيا",
    "الاسكندريه",
    "السويس",
    "الشرقيه",
    "بنى سويف",
    "الغربيه",
    "الغردقه",
    "شرم الشيخ"
  ];
  List<String> AllowedLocations = [
    "القاهره",
    "الاقصر",
    "المنيا",
    "الاسكندريه",
    "السويس",
    "الشرقيه",
    "بنى سويف",
    "الغربيه",
    "الغردقه",
    "شرم الشيخ"
  ];
  void _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Center(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close)),
                    Text(
                      "Filter",
                      style: TextStyle(color: green),
                    ),
                  ],
                ),
              ),
              content: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  for (var e in Locations)
                    Button(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (AllowedLocations.contains(e)) {
                          return green;
                        } else {
                          return grey;
                        }
                      })),
                      ch: Text(e),
                      onPress: () {
                        setState(() {
                          if (AllowedLocations.contains(e)) {
                            AllowedLocations.remove(e);
                          } else {
                            AllowedLocations.add(e);
                          }
                        });
                      },
                    )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).selectedRowColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Row(
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    isfood = true;
                  });
                },
                child: (Text(
                  "طعام",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      decoration: isfood
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationThickness: 1.7,
                      decorationStyle: TextDecorationStyle.dashed),
                ))),
            TextButton(
                onPressed: () {
                  setState(() {
                    isfood = false;
                  });
                },
                child: (Text(
                  "غير طعام",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      decoration: isfood
                          ? TextDecoration.none
                          : TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed,
                      decorationThickness: 1.7),
                )))
          ],
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: isfood == true
                  ? Container(
                      height: 70.h,
                      color: Theme.of(context).cardColor,
                      width: MediaQuery.sizeOf(context).width,
                      alignment: Alignment.topRight,
                      child: EnableButton(
                          onPress: () {
                            _showAlertDialog(context);
                          },
                          backgroundColor: green,
                          ch: Icon(
                            Icons.format_align_center,
                            color: white,
                          )),
                    )
                  : Container(
                      color: Theme.of(context).cardColor,
                      height: 70.h,
                      // width: MediaQuery.sizeOf(context).width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EnableButton(
                              onPress: () {
                                _showAlertDialog(context);
                              },
                              backgroundColor: green,
                              ch: Icon(
                                Icons.format_align_center,
                                color: white,
                              )),
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
          ),
          Container(
            color: Theme.of(context).cardColor,
            height: MediaQuery.sizeOf(context).height - 211.h,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("User")
                  .where("location", whereIn: AllowedLocations)
                  .snapshots(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
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
                      String phoneNumber =
                          userSnapshot.data!.docs[userIndex]["phoneNumber"];
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
                            .collection(isfood
                                ? "freefood"
                                : enable_free
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
                              /////////////////////////////////////////////// Extract product data
                              String productName =
                                  subSnapshot.data!.docs[i]["product_name"];
                              String img1 = subSnapshot.data!.docs[i]["img1"];
                              String city = subSnapshot.data!.docs[i]["city"];
                              String userProfileImg =
                                  subSnapshot.data!.docs[i]["user_profile_img"];
                              String productUsername =
                                  subSnapshot.data!.docs[i]["username"];
                              String info = subSnapshot.data!.docs[i]["info"];
                              String productId =
                                  subSnapshot.data!.docs[i]["productId"];

                              //Product is the parent of all products types

                              Product productData = Product(
                                // at first form only///
                                productId: productId,
                                product_name: productName,
                                img1: img1,
                                city: city,
                                user_profile_img: userProfileImg,
                                username: productUsername,
                                info: info,
                              );
                              ////////////////////////////////////////////////////////////////////

                              isfood
                                  ? productData = FreeProduct(
                                      productId: productId,
                                      user_profile_img: userProfileImg,
                                      img1: img1,
                                      city: city,
                                      product_name: productName,
                                      info: info,
                                      username: username,
                                    )
                                  : enable_free
                                      ? productData = FreeProduct(
                                          productId: productId,
                                          user_profile_img: userProfileImg,
                                          img1: img1,
                                          city: city,
                                          product_name: productName,
                                          info: info,
                                          username: username,
                                        )
                                      : enable_sells
                                          ? productData = selle_prod(
                                              prodPrice: subSnapshot
                                                  .data!.docs[i]["prodPrice"],
                                              productId: productId,
                                              user_profile_img: userProfileImg,
                                              img1: img1,
                                              city: city,
                                              product_name: productName,
                                              info: info,
                                              username: username,
                                            )
                                          : enable_lend
                                              ? productData = BorrowProduct(
                                                  days: subSnapshot
                                                      .data!.docs[i]["days"],
                                                  prodPrice: subSnapshot.data!
                                                      .docs[i]["prodPrice"],
                                                  productId: productId,
                                                  user_profile_img:
                                                      userProfileImg,
                                                  img1: img1,
                                                  city: city,
                                                  product_name: productName,
                                                  info: info,
                                                  username: username,
                                                )
                                              : productData = Wanted(
                                                  productId: productId,
                                                  user_profile_img:
                                                      userProfileImg,
                                                  img1: img1,
                                                  city: city,
                                                  product_name: productName,
                                                  info: info,
                                                  username: username,
                                                );

                              products.add(productData); //  Product object
                            }

                            userData.aproduct = products;

                            return products.length != 0
                                ? Container(
                                    // height: 250.h,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: products.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Productitem(
                                          // widget  receve product opject
                                          theUser: userData,
                                          myproduct: products[index],
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
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).cardColor,
        width: 250.w,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: yello,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  )),
              width: 250.w,
              height: 200.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: green,
                    radius: 30.r,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.curuser.userimg),
                      radius: 27.r,
                    ),
                  ),
                  Text(
                    widget.curuser.username,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: black),
                  ),
                  Text(
                    widget.curuser.phonenumber,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/SingnupComplete',
                          arguments: {'the_user': widget.curuser});
                    },
                    child: Text(
                      "edit profile",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: green,
                          fontSize: 15.sp,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: green_shade,
                  ),
                  SizedBox(
                    width: 10.w,
                  ), /*
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "الاعدادات",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: green,
                          fontSize: 15.sp,
                          decoration: TextDecoration.underline),
                    ),
                  )*/
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: red,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                    onTap: () {
                      if (Auth.auth.currentUser != null) {
                        Auth.signout();
                        Navigator.pushNamed(context, '/');
                      }
                    },
                    child: Text(
                      "تسجيل الخروج",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: green,
                          fontSize: 15.sp,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  InkWell(
                    child: CircleAvatar(
                        backgroundColor: Theme.of(context).selectedRowColor,
                        child: isdark
                            ? Icon(Icons.light_mode_outlined)
                            : Icon(Icons.mode_night_rounded)),
                    onTap: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();

                      setState(() {
                        isdark = !isdark;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
