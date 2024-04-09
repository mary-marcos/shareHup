import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:share_meal/models/user.dart';
import 'package:share_meal/screens/add_new.dart/add_newe.dart';
import 'package:share_meal/screens/add_new.dart/choose_free_give.dart';
import 'package:share_meal/screens/product/item_details.dart';

import 'package:share_meal/screens/profile/profile.dart';
import 'package:share_meal/screens/sign/constrains.dart';
import 'package:share_meal/screens/sign/signin.dart';
import 'package:share_meal/screens/sign/signup.dart';
import 'package:share_meal/screens/sign/signup_complete.dart';
import 'package:share_meal/screens/sign/signup_info.dart';
import 'package:share_meal/screens/sign/splash.dart';
import 'package:share_meal/screens/sign/welcome.dart';
import 'package:share_meal/screens/thehome/home.dart';
import 'package:share_meal/screens/thehome/navbar.dart';

Color green = Color.fromARGB(255, 49, 71, 56);
Color pink = Color.fromARGB(255, 245, 181, 245);
Color yello = Color.fromARGB(255, 255, 255, 108);
Color light_green = Color.fromARGB(255, 115, 204, 143);
Color black = Color.fromARGB(255, 8, 8, 4);
Color white = Color.fromARGB(255, 250, 250, 238);
Color green_shade = Color.fromARGB(255, 66, 117, 82);
Color red = Color.fromARGB(255, 228, 28, 14);
Color grey = Color.fromARGB(255, 105, 93, 92);
Color blacgrey = Color.fromARGB(255, 39, 35, 35);
Color lightgrey = Color.fromARGB(255, 214, 207, 206);

//bool isdark = false;
bool isdark = false;

swicththemes() {
  isdark = !isdark;
  isdark
      ? white = Color.fromARGB(255, 8, 8, 4)
      : Color.fromARGB(255, 250, 250, 238);
  isdark
      ? black = Color.fromARGB(255, 250, 250, 238)
      : Color.fromARGB(255, 8, 8, 4);
  //isdark?white=Color.fromARGB(255, 8, 8, 4):Color.fromARGB(255, 250, 250, 238);
}

Map<String, Widget Function(BuildContext)> myRoutes = {
  '/': (context) => Splash(),
  '/nav': (context) => nav(),
  '/Singnup': (context) => Singnup(),
  '/Profile': (context) => Profile(),
  '/SingnupInfo': (context) => SingnupInfo(),
  '/SingnupComplete': (context) => SingnupComplete(),
  '/Constrains': (context) => Constrains(),
  '/Login': (context) => Login(),
  '/chooseCategory': (context) => ChooseFreeGive(),
  '/addnew': (context) => AddNew(),
  '/ItemDetails': (context) => ItemDetails(),
};
