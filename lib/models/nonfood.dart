class nonfood {
  String username;
  String user_profile_img;
  String text_food;

  String? foodimg;
  String? date;
  nonfood(
      {required this.text_food,
      this.foodimg,
      this.date,
      required this.username,
      required this.user_profile_img});
}
