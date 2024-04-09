import 'package:share_meal/models/food.dart';
import 'package:share_meal/models/nonfood.dart';
import 'package:share_meal/models/product.dart';

class User_m {
  final String fullName;
  final String Gender;
  final String location;
  final String phonenumber;
  final String username;
  final String userID;
  String userimg;
  List<Product>? aproduct;

  //List<food>? foods;
  //List<nonfood>? n_foods;
  List<BorrowProduct>? BorrowProduc;
  List<selle_prod>? selle_pro;

  List<FreeProduct>? FreeProduc;

  User_m(
      {required this.userID,
      required this.fullName,
      required this.Gender,
      required this.location,
      required this.phonenumber,
      required this.username,
      required this.userimg,

      // this.foods,
      // this.n_foods
      this.BorrowProduc,
      this.FreeProduc,
      this.selle_pro,
      this.aproduct});
}
