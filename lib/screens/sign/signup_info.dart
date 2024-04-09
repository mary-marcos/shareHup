import 'package:share_meal/Blogic/firebase/auth.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:share_meal/constants/buttons.dart';
import 'package:share_meal/constants/dropdown.dart';
import 'package:share_meal/widgets/stac.dart';

import 'package:share_meal/constants/textfield.dart';
import 'package:flutter/material.dart';

class SingnupInfo extends StatefulWidget {
  SingnupInfo({super.key});

  @override
  State<SingnupInfo> createState() => _SingnupInfoState();
}

class _SingnupInfoState extends State<SingnupInfo> {
  String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{3,4}$'; //

  bool isEmailValid(String email) {
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  bool invalidemail = false;
  bool invalidpassword = false;
  bool? isChecked = false;
  TextEditingController email_contr = TextEditingController();
  TextEditingController password_contr = TextEditingController();

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
                        Navigator.pushReplacementNamed(context, '/Singnup');
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp)),
                  SizedBox(
                    width: 50,
                  ),
                  Text("طلب الانضمام")
                ],
              ),
              Text(
                "ادخل البيانات التاليه لارسال طلب الانضمام",
                // softWrap: false,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              textField(
                  controller: email_contr,
                  keybordType: TextInputType.text,
                  tittle: "البريد الالكترونى"),
              invalidemail
                  ? Text(
                      "الإيميل  يجب أن يحتوي على شكل صحيح، مثل: example@example.com, ",
                      style: TextStyle(color: red, fontSize: 12),
                    )
                  : SizedBox(),
              textField(
                  controller: password_contr,
                  keybordType: TextInputType.visiblePassword,
                  tittle: " كلمه المرور"),
              invalidpassword
                  ? Text(
                      "كلمه المرور لا تقل عن 6 رموز",
                      style: TextStyle(color: red, fontSize: 12),
                    )
                  : SizedBox(),
              SizedBox(
                height: 8,
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    fillColor: MaterialStateColor.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return green; // Color when checkbox is selected
                      }
                      return white; // Color when checkbox is not selected
                    }),
                    checkColor: white,
                    tristate: false,
                    value: isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        isChecked = newValue;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        'الموافقه على ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/Constrains');
                        },
                        child: Text(
                          'الشروط والاحكام',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  decoration: TextDecoration.underline,
                                  textBaseline: TextBaseline.ideographic,
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Button(
                onPress: () {
                  if (email_contr.text == "" ||
                      password_contr.text == "" ||
                      isChecked == false) {}
                  if (!isEmailValid(email_contr.text)) {
                    setState(() {
                      invalidemail = true;
                    });
                  } else {
                    setState(() {
                      invalidemail = false;
                    });
                  }
                  if (password_contr.text.length < 6) {
                    setState(() {
                      print(password_contr.text.length);
                      invalidpassword = true;
                      print(invalidpassword);
                    });
                  } else {
                    print(password_contr.text.length);

                    setState(() {
                      invalidpassword = false;
                      print(invalidpassword);
                    });
                  }

                  if (invalidemail == false &&
                      invalidpassword == false &&
                      isChecked == true) {
                    Auth.signupWithEmailAnd(
                        email: email_contr.text, password: password_contr.text);

                    Navigator.pushReplacementNamed(context, '/SingnupComplete');
                  }
                },
                ch: Text(
                  "طلب الانضمام",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                style: Theme.of(context).elevatedButtonTheme.style,
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
