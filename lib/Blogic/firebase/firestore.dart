import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_meal/models/product.dart';
import 'package:share_meal/models/user.dart';
//import 'package:mysocial/models/post_model.dart';
//import 'package:mysocial/models/user.dart';

class FireStore {
  static final auth = FirebaseAuth.instance;

  static Future<void> Add(
    User_m user,
  ) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(auth.currentUser!.uid)
        .set({
      //"final String"user
      "userID": user.userID,
      "userName": user.username,
      "fullname": user.fullName,
      "phoneNumber": user.phonenumber,
      "Gender": user.Gender,
      "location": user.location,
      "userimg": user.userimg,
      //"Stories": user.Stories,
      //"posts": user.posts
    });
  }

  static Future<void> AddfreeFoodprod(
    FreeProduct myprod,
  ) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(auth.currentUser!.uid)
        .collection('freefood')
        .add({
      "productId": myprod.productId,
      "username": myprod.username,
      "user_profile_img": myprod.user_profile_img,
      "img1": myprod.img1,
      "img2": myprod.img2,
      "img3": myprod.img3,
      "info": myprod.info,
      "product_name": myprod.product_name,
      "city": myprod.city,
      "userid": myprod.userid,
    });
  }

  static Future<void> Add_Wanted(
    Wanted myprod,
  ) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(auth.currentUser!.uid)
        .collection('Wanted')
        .add({
      "productId": myprod.productId,
      "username": myprod.username,
      "user_profile_img": myprod.user_profile_img,
      "img1": myprod.img1,
      "img2": myprod.img2,
      "img3": myprod.img3,
      "info": myprod.info,
      "product_name": myprod.product_name,
      "city": myprod.city,
      "userid": myprod.userid,
    });
  }

  static Future<void> AddfreeNonFoodprod(
    FreeProduct myprod,
  ) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(auth.currentUser!.uid)
        .collection('freenonfood')
        .add({
      "productId": myprod.productId,
      "username": myprod.username,
      "user_profile_img": myprod.user_profile_img,
      "img1": myprod.img1,
      "img2": myprod.img2,
      "img3": myprod.img3,
      "info": myprod.info,
      "product_name": myprod.product_name,
      "city": myprod.city,
      "userid": myprod.userid,
    });
  }

  static Future<void> AddBorrowprod(
    BorrowProduct myprod,
  ) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(auth.currentUser!.uid)
        .collection('Borrowprod')
        .add({
      "productId": myprod.productId,
      "username": myprod.username,
      "user_profile_img": myprod.user_profile_img,
      "img1": myprod.img1,
      "img2": myprod.img2,
      "img3": myprod.img3,
      "info": myprod.info,
      "product_name": myprod.product_name,
      "prodPrice": myprod.prodPrice,
      "days": myprod.days,
      "city": myprod.city,
      "userid": myprod.userid,
    });
  }

  static Future<void> AddSelesprod(
    selle_prod myprod,
  ) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(auth.currentUser!.uid)
        .collection('Sells_sprod')
        .add({
      "productId": myprod.productId,
      "userid": myprod.userid,
      "username": myprod.username,
      "user_profile_img": myprod.user_profile_img,
      "img1": myprod.img1,
      "img2": myprod.img2,
      "img3": myprod.img3,
      "info": myprod.info,
      "product_name": myprod.product_name,
      "prodPrice": myprod.prodPrice,
      "city": myprod.city,
    });
  }

  static Future<User_m> getCurrent() async {
    late User_m userm;
    await FirebaseFirestore.instance
        .collection('User')
        .doc(auth.currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        userm = User_m(
          userID: snapshot.data()!["userID"],
          Gender: snapshot.data()!["fullname"],
          fullName: snapshot.data()!["fullname"],
          location: snapshot.data()!["location"],
          phonenumber: snapshot.data()!["phoneNumber"],
          username: snapshot.data()!["userName"],
          userimg: snapshot.data()!["userimg"],
        );

        print("==========${userm.username}===========");

        return userm;
      } else {
        userm = User_m(
            userID: "userID",
            Gender: "Gender",
            fullName: "fullName",
            location: "location",
            phonenumber: "phonenumber",
            username: "username",
            userimg: "userimg");
      }
    });
    return userm;
  }
}
