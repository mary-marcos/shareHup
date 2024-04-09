import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_meal/Blogic/firebase/auth.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:share_meal/constants/buttons.dart';

import 'package:share_meal/widgets/stac.dart';

import 'package:flutter/material.dart';

class Singnup extends StatefulWidget {
  Singnup({super.key});

  @override
  State<Singnup> createState() => _SingnupState();
}

class _SingnupState extends State<Singnup> {
  @override
  Widget build(BuildContext context) {
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
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp)),
                  SizedBox(
                    width: 50,
                  ),
                  Text("طلب الانضمام")
                ],
              ),

              //Logo
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                child: Image.asset(
                  'assets/images/sharing.png',
                  width: 120.w,
                  // height: constraints.maxHeight * 0.4,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "اختر طريقه طلب الانضمام",
                // softWrap: false,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0.h),
              Button(
                onPress: () {
                  Navigator.pushReplacementNamed(context, '/SingnupInfo');
                },
                ch: Text(
                  "with Email",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                style: Theme.of(context).elevatedButtonTheme.style,
              ),
              SizedBox(
                height: 50.h,
              ),
              Button(
                onPress: () {
                  Auth.signInWithGoogle();
                  if (Auth.auth.currentUser != null) {
                    Navigator.pushNamed(context, '/SingnupComplete');
                  }
                },
                ch: Text(
                  " with Google",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                style: Theme.of(context)
                    .elevatedButtonTheme
                    .style!
                    .copyWith(backgroundColor: MaterialStatePropertyAll(red)),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
