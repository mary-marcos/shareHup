class Product {
  Product(
      {required this.product_name,
      required this.img1,
      required this.city,
      this.img2,
      this.img3,
      required this.user_profile_img,
      required this.username,
      // required this.category,
      required this.info,
      this.days,
      this.prodPrice,
      this.userid,
      required this.productId});

  String user_profile_img;
  String username;
  String city;
  String product_name;
  String img1;
  String? img2;
  String? img3;
  String info;
  int? days;
  int? prodPrice;
  dynamic userid;
  String productId;
}

class Wanted extends Product {
  Wanted(
      {required super.productId,
      required super.product_name,
      required super.img1,
      required super.city,
      required super.user_profile_img,
      required super.username,
      required super.info,
      super.img2,
      super.img3,
      super.userid});

  // String? category;
}

class FreeProduct extends Product {
  FreeProduct(
      {required super.productId,
      required super.product_name,
      required super.img1,
      required super.city,
      required super.user_profile_img,
      required super.username,
      required super.info,
      super.img2,
      super.img3,
      super.userid});

  // String? category;
}

class selle_prod extends Product {
  selle_prod(
      {required super.productId,
      required super.prodPrice,
      required super.product_name,
      required super.img1,
      required super.user_profile_img,
      required super.username,
      required super.info,
      required super.city,
      super.img2,
      super.img3,
      super.userid});
}

class BorrowProduct extends Product {
  BorrowProduct(
      {required super.productId,
      required super.days,
      required super.product_name,
      required super.img1,
      required super.info,
      required super.user_profile_img,
      required super.username,
      required super.prodPrice,
      required super.city,
      super.img2,
      super.img3,
      super.userid});
}
