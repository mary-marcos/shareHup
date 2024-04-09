import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:share_meal/Blogic/firebase/auth.dart';
import 'package:share_meal/screens/sign/welcome.dart';
import 'package:share_meal/screens/thehome/navbar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.fadeIn(
          backgroundColor: Colors.white,
          onInit: () {
            debugPrint("On Init");
          },
          onEnd: () {
            debugPrint("On End");
          },
          childWidget: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(
              'assets/images/sharing.png',
            ),
          ),
          onAnimationEnd: () => debugPrint("On Fade In End"),
          nextScreen: Auth.auth.currentUser != null ? nav() : Welcome()),
    );
  }
}
