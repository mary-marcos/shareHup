import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share_meal/Blogic/firebase/auth.dart';
import 'package:share_meal/screens/thehome/navbar.dart';
import 'package:share_meal/widgets/stac.dart';
import 'package:share_meal/constants/textfield.dart';

import 'package:share_meal/constants/buttons.dart';
import 'package:share_meal/constants/constans.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordWrong = false;
  bool visualPassword = true;
  TextEditingController emailcontr = TextEditingController();
  TextEditingController passcontr = TextEditingController();
  String emailPattern =
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // Regex pattern for basic email validation

  bool isEmailValid(String email) {
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  bool invalidemail = false;
  bool invalidpassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stac(list_widgets: [
        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize:,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 260,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_ios_sharp)),
                          ],
                        ),
                        //Logo
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 0),
                          child: Image.asset(
                            'assets/images/sharing.png',
                            width: constraints.maxWidth * 0.4,
                            // height: constraints.maxHeight * 0.4,
                          ),
                        ),
                        const Text("SAREHUB",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              shadows: [
                                Shadow(
                                    offset: Offset(0, 15),
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    blurRadius: 90),
                                Shadow(
                                    offset: Offset(0, 20),
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    blurRadius: 90),
                                Shadow(
                                    offset: Offset(0, 20),
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    blurRadius: 80),
                              ],
                              color: Color(0xFFFFFFFF),
                            )),
                        Container(
                          height: 10,
                          width: 105,
                          decoration: BoxDecoration(
                            // color: Colors.blue,

                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 6.0,
                                spreadRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textField(
                            controller: emailcontr,
                            tittle: "البريد الالكترونى",
                            keybordType: TextInputType.emailAddress),
                        textField(
                            controller: passcontr,
                            tittle: "كلمه المرور",
                            keybordType: TextInputType.visiblePassword,
                            obscureTex: true,
                            visibleIcon: true),
                        InkWell(
                            onTap: () {},
                            child: Text(
                              "اعاده تعيين كلمه مرور؟",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 14, color: yello),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Button(
                          onPress: () {
                            if (!isEmailValid(emailcontr.text)) {
                              setState(() {
                                invalidemail = true;
                              });
                            } else {
                              setState(() {
                                invalidemail = false;
                              });
                            }
                            Auth.signInWithEmailAnd(
                                email: emailcontr.text,
                                password: passcontr.text);
                            Navigator.pushReplacementNamed(context, '/nav');
                          },
                          /*
                          Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => nav(),
                                      ));

                          */
                          ch: Text(
                            "تسجيل الدخول",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          style: Theme.of(context).elevatedButtonTheme.style,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}
