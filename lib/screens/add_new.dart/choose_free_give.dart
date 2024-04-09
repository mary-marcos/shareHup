import 'package:flutter/material.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:share_meal/screens/thehome/navbar.dart';

class ChooseFreeGive extends StatelessWidget {
  const ChooseFreeGive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اختيار الفئه"),
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            listtileitem(
              backcolor: Color.fromARGB(255, 81, 16, 94),
              icon: Icons.card_giftcard,
              onPress: () {
                Navigator.pushNamed(
                  context,
                  '/addnew',
                  arguments: {
                    'transaction': "freefood",
                  },
                );
              },
              tittle: 'طعام',
              subtittle: "تعطى مجانا طعام  ",
            ),
            listtileitem(
              backcolor: red,
              icon: Icons.chair_rounded,
              onPress: () {
                Navigator.pushNamed(
                  context,
                  '/addnew',
                  arguments: {
                    'transaction': "freenonfood",
                  },
                );
              },
              tittle: "غير طعام",
              subtittle: "تعطى مجانا ملابس /ادوات/العاب/الخ",
            ),
          ],
        ),
      ),
    );
  }
}
