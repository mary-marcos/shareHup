import 'dart:ui';

import 'package:share_meal/constants/buttons.dart';
import 'package:flutter/material.dart';

class stac extends StatelessWidget {
  stac({
    required this.list_widgets,
    super.key,
  });
  final List<Widget> list_widgets;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/sharefood.jpg',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
              filterQuality: FilterQuality.low,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            for (var i in list_widgets) i
          ],
        ),
      );
    });
  }
}
