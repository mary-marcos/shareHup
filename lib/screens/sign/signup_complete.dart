import 'dart:io';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_meal/Blogic/firebase/auth.dart';
import 'package:share_meal/Blogic/firebase/firestore.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:share_meal/constants/buttons.dart';
import 'package:share_meal/constants/dropdown.dart';
import 'package:share_meal/models/user.dart';
import 'package:share_meal/screens/product/item_details.dart';
import 'package:share_meal/widgets/stac.dart';

import 'package:share_meal/constants/textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:share_meal/Blogic/firebase/auth.dart';
import 'package:share_meal/Blogic/firebase/firestore.dart';
import 'package:share_meal/constants/buttons.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:share_meal/constants/textfield.dart';
import 'package:share_meal/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SingnupComplete extends StatefulWidget {
  SingnupComplete({super.key});

  @override
  State<SingnupComplete> createState() => _SingnupCompleteState();
}

bool isselectgenderNameUsername = true;
bool iscorrecrPhone = true;
String selectedLocation = 'القاهره';
String butontext = "طلب الانضمام";
String networkimg =
    "https://i0.wp.com/vssmn.org/wp-content/uploads/2018/12/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png?fit=860%2C681&ssl=1";
TextEditingController namecontr = TextEditingController();
TextEditingController usernamecontr = TextEditingController();
TextEditingController phonecontr = TextEditingController();
File? file;
bool getimg = false;
var url;
String pagetittle = "طلب الانضمام";
String pagesubtittle = "ادخل البيانات التاليه لارسال طلب الانضمام";

class _SingnupCompleteState extends State<SingnupComplete> {
  @override
  List<String> options = [
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
      var ref = FirebaseStorage.instance.ref("User/$imgname");
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
      var ref = FirebaseStorage.instance.ref("User/$imgname");
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

  User_m? the_user = null;
  String? selectedGender;

  Map<String, dynamic>? args = null;
  void showargs(Context) {
    if (args != null) {
      the_user = args?['the_user'];
      if (the_user != null) {
        selectedLocation = the_user != null ? the_user!.location : 'القاهره';
        namecontr.text = the_user!.fullName;
        usernamecontr.text = the_user!.fullName;
        phonecontr.text = the_user!.phonenumber
            .substring(max(0, the_user!.phonenumber.length - 10));
        //selectedGender = the_user!.Gender;
        networkimg = the_user!.userimg;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        butontext = "تعديل";
        pagetittle = "طلب التعديل ";
        pagesubtittle = "اضغط على الزر لتحميل بياناتك ";
      }
    });
    return Scaffold(
        body: stac(list_widgets: [
      SingleChildScrollView(
        child: Container(
          // height: ,
          margin: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp)),
                  SizedBox(
                    width: 50,
                  ),
                  Text(pagetittle)
                ],
              ),
              Text(
                pagesubtittle,
                // softWrap: false,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    showargs(context);
                  });
                },
                icon: Icon(Icons.download),
              ),
              getimg
                  ? Container(
                      alignment: Alignment.centerRight,
                      height: 130.h,
                      width: 130.w,
                      decoration: BoxDecoration(
                          color: white,
                          image: DecorationImage(
                              image: FileImage(file!), fit: BoxFit.cover)),
                    )
                  : InkWell(
                      child: Container(
                          height: 100.h,
                          width: 100.w,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(networkimg),
                            radius: 50.r,
                          )),
                      onTap: () {
                        _showAlertDialog(context);
                      },
                    ),
              iscorrecrPhone
                  ? SizedBox()
                  : Text(
                      "ادخل رقم الهاتف صحيحا",
                      style: TextStyle(color: red),
                    ),
              isselectgenderNameUsername
                  ? SizedBox()
                  : Text(
                      "ادخل جميع البيانات المطلوبه",
                      style: TextStyle(color: red),
                    ),
              textField(
                  controller: namecontr,
                  keybordType: TextInputType.text,
                  tittle: "الاسم بالكامل"),
              textField(
                  maxlength: 10,
                  isphone: true,
                  controller: phonecontr,
                  keybordType: TextInputType.phone,
                  tittle: "رقم الهاتف"),
              textField(
                  controller: usernamecontr,
                  keybordType: TextInputType.text,
                  tittle: "اسم المستخدم "),
              SizedBox(
                height: 8,
              ),
              DropDownButton(
                options: options,
                selectedOption: selectedLocation,
                onChanged: (value) {
                  selectedLocation = value;
                },
              ),
              Row(
                children: [
                  Text(
                    'الجنس ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'ذكر',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      Text('ذكر'),
                      SizedBox(width: 10), // Adjust the spacing as needed
                      Radio(
                        value: 'انثى',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      Text('انثى'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Button(
                onPress: () {
                  if (selectedGender == null ||
                      namecontr.text == "" ||
                      usernamecontr.text == "" ||
                      getimg == false) {
                    setState(() {
                      isselectgenderNameUsername = false;
                    });
                  } else {
                    setState(() {
                      isselectgenderNameUsername = true;
                    });
                  }

                  if (phonecontr.text.length < 10 || phonecontr.text == "") {
                    setState(() {
                      iscorrecrPhone = false;
                      print(" =========$iscorrecrPhone=================");
                    });
                  } else {
                    setState(() {
                      iscorrecrPhone = true;
                    });
                  }
                  if (isselectgenderNameUsername == true &&
                      iscorrecrPhone == true) {
                    FireStore.Add(User_m(
                        userID: Auth.auth.currentUser!.uid,
                        userimg: url,
                        fullName: namecontr.text,
                        Gender: selectedGender!,
                        location: selectedLocation,
                        phonenumber: "+20${phonecontr.text}",
                        username: usernamecontr.text));
                    args != null
                        ? Navigator.pushReplacementNamed(context, '/nav')
                        : Navigator.pushReplacementNamed(context, '/Login');
                  }
                },
                ch: Text(
                  butontext,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                style: Theme.of(context).elevatedButtonTheme.style,
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
