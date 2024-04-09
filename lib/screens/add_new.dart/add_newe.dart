import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:share_meal/Blogic/firebase/auth.dart';
import 'package:share_meal/Blogic/firebase/firestore.dart';
import 'package:share_meal/constants/buttons.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:share_meal/constants/textfield.dart';
import 'package:share_meal/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:share_meal/models/user.dart';

class AddNew extends StatefulWidget {
  AddNew({
    super.key,
  });
  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  late User_m curuser;
  Future<void> getuser() async {
    curuser = await FireStore.getCurrent();
    // print("${curuser.username}");
    setState(() {});
    // Rebuild the widget after user data is fetched
  }

  @override
  void initState() {
    super.initState();
    getuser();
  }

  /* void didChangeDependencies() {
  super.didChangeDependencies();
 
  final Map<String, dynamic>? args =
      ModalRoute.of(context )?.settings.arguments as Map<String, dynamic>?;
  if (args != null && args.containsKey('transaction')) {
    transaction = args['transaction'] as String;
    // myprod = args?['Product'];
   // backimg = myprod.img1;
  }
  // You can add additional logic here if needed
  }*/
  @override
  bool submit = false;
  var url;
  TextEditingController? tittlecontroller = TextEditingController();
  TextEditingController? descrip_controller = TextEditingController();
  TextEditingController? price_controller = TextEditingController();
  TextEditingController? lend_days_controller = TextEditingController();
  File? file;
  bool getimg = false;
  uploadImgcamera() async {
    ImagePicker pickeri = ImagePicker();
    XFile? img = await pickeri.pickImage(source: ImageSource.camera);

    if (img != null) {
      setState(() {
        getimg = true;
        file = File(img.path);
      });
      var metadata = SettableMetadata(contentType: "image/jpg");
      var imgname = basename(img.path);
      var ref = FirebaseStorage.instance.ref("products/$imgname");
      await ref.putFile(file!, metadata);
      url = await ref.getDownloadURL();
      print(url);
    }
  }

  uploadImggallery() async {
    ImagePicker pickeri = ImagePicker();
    XFile? img = await pickeri.pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() {
        getimg = true;
        file = File(img.path);
      });
      var metadata = SettableMetadata(contentType: "image/jpg");
      var imgname = basename(img.path);
      var ref = FirebaseStorage.instance.ref("products/$imgname");
      await ref.putFile(file!, metadata);
      url = await ref.getDownloadURL();
      print(url);
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
            'اختر طريقه تحميل الصوره',
            style: TextStyle(color: black),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Action for the camera button
                await uploadImgcamera();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Camera'),
            ),
            TextButton(
              onPressed: () async {
                // Action for the gallery button
                await uploadImggallery();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  late String transaction;

  @override
  Widget build(BuildContext context) {
    String appbartittle = "طعام مجانى";
    String? transaction = "";
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('transaction')) {
      transaction = args['transaction'] as String;

      // myprod = args?['Product'];
      // backimg = myprod.img1;
      switch (transaction) {
        case "freefood":
          appbartittle = "طعام مجانى";
          break;
        case "freenonfood":
          appbartittle = "غير طعام مجانى";
          break;
        case "borrow":
          appbartittle = " اقراض";
          break;
        case "sell":
          appbartittle = "البيع";

          break;
        case "Wanted":
          appbartittle = "اسال ما تحتاج";

          break;
        default:
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appbartittle,
        ),
      ),
      body: curuser == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                color: Theme.of(context).cardColor,
                child: Column(
                  children: [
                    submit
                        ? Text(
                            "data cant be blank",
                            style: TextStyle(color: red),
                          )
                        : SizedBox(),
                    getimg
                        ? Container(
                            alignment: Alignment.centerRight,
                            height: 130.h,
                            width: 130.w,
                            decoration: BoxDecoration(
                                color: white,
                                image: DecorationImage(
                                    image: FileImage(file!),
                                    fit: BoxFit.cover)),
                          )
                        : InkWell(
                            child: Container(
                                height: 100.h,
                                width: 100.w,
                                child: Image.asset("assets/images/addnew.png")),
                            onTap: () {
                              _showAlertDialog(context);
                            },
                          ),
                    SizedBox(
                      height: 30.h,
                    ),
                    textFieldAdd(
                      keybordType: TextInputType.text,
                      tittle: "اسم المنتج ",
                      controller: tittlecontroller,
                    ),
                    textFieldAdd(
                      keybordType: TextInputType.text,
                      tittle: "الوصف",
                      controller: descrip_controller,
                    ),
                    transaction == "sell" || transaction == "borrow"
                        ? textFieldAdd(
                            keybordType: TextInputType.number,
                            tittle: "السعر",
                            visibleIcon: true,
                            controller: price_controller,
                          )
                        : SizedBox(),
                    transaction == "borrow"
                        ? textFieldAdd(
                            keybordType: TextInputType.number,
                            tittle: "عدد ايام الاقراض",
                            controller: lend_days_controller,
                          )
                        : SizedBox(),
                    EnableIcobButton(
                      icon: Icon(Icons.add),
                      onPress: () {
                        if (getimg == false ||
                            tittlecontroller!.text == "" ||
                            descrip_controller!.text == "") {
                          setState(() {
                            submit = true;
                            print(
                                "$submit =====================================${curuser.userimg}");
                          });
                        } else {
                          setState(() {
                            submit = false;
                            print(
                                "$submit =====================================${tittlecontroller!.text}");
                          });
                        }

                        if (submit ==
                            false) // submit == false mean data isnt blank
                        {
                          switch (transaction) {
                            case "freefood":
                              String productId = FirebaseFirestore.instance
                                  .collection('User')
                                  .doc()
                                  .id;
                              FireStore.AddfreeFoodprod(FreeProduct(
                                  productId: productId,
                                  userid: Auth.auth.currentUser!.uid,
                                  city: curuser.location,
                                  username: curuser.username,
                                  user_profile_img: curuser.userimg!,
                                  img2: "im2",
                                  img3: "im3",
                                  product_name: tittlecontroller!.text,
                                  img1: url,
                                  info: descrip_controller!.text));
                              break;
                            case "freenonfood":
                              String productId = FirebaseFirestore.instance
                                  .collection('User')
                                  .doc()
                                  .id;
                              FireStore.AddfreeNonFoodprod(FreeProduct(
                                  productId: productId,
                                  userid: Auth.auth.currentUser!.uid,
                                  city: curuser.location,
                                  username: curuser.username,
                                  user_profile_img: curuser.userimg,
                                  product_name: tittlecontroller!.text,
                                  img1: url,
                                  info: descrip_controller!.text));
                              break;

                            case "borrow":
                              String productId = FirebaseFirestore.instance
                                  .collection('User')
                                  .doc()
                                  .id;
                              FireStore.AddBorrowprod(BorrowProduct(
                                  productId: productId,
                                  userid: Auth.auth.currentUser!.uid,
                                  city: curuser.location,
                                  days: int.parse(lend_days_controller!.text),
                                  prodPrice: int.parse(price_controller!.text),
                                  username: curuser.username,
                                  user_profile_img: curuser.userimg,
                                  product_name: tittlecontroller!.text,
                                  img1: url,
                                  info: descrip_controller!.text));
                              break;
                            case "sell":
                              String productId = FirebaseFirestore.instance
                                  .collection('User')
                                  .doc()
                                  .id;
                              FireStore.AddSelesprod(selle_prod(
                                  productId: productId,
                                  userid: Auth.auth.currentUser!.uid,
                                  city: curuser.location,
                                  prodPrice: int.parse(price_controller!.text),
                                  username: curuser.username,
                                  user_profile_img: curuser.userimg,
                                  product_name: tittlecontroller!.text,
                                  img1: url,
                                  info: descrip_controller!.text));
                              break;
                            case "Wanted":
                              String productId = FirebaseFirestore.instance
                                  .collection('User')
                                  .doc()
                                  .id;
                              FireStore.Add_Wanted(Wanted(
                                  productId: productId,
                                  userid: Auth.auth.currentUser!.uid,
                                  city: curuser.location,
                                  username: curuser.username,
                                  user_profile_img: curuser.userimg,
                                  product_name: tittlecontroller!.text,
                                  img1: url,
                                  info: descrip_controller!.text));
                              break;

                            default:
                          }
                          Navigator.pushReplacementNamed(context, '/nav');
                        }
                        //await uploadImg();
                      },
                      ch: Text(
                        "submit",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
