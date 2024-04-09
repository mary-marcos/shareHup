import 'constans.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class Button extends StatelessWidget {
  Button({super.key, this.onPress, required this.ch, this.style});
  final void Function()? onPress;
  final Widget? ch;
  ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress, child: ch, style: style);
  }
}

class EnableButton extends StatelessWidget {
  EnableButton({
    super.key,
    this.onPress,
    required this.ch,
    required this.backgroundColor,
  });
  final void Function()? onPress;
  final Widget? ch;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPress,
        child: ch,
        style: ElevatedButtonTheme.of(context).style!.copyWith(
            backgroundColor: MaterialStatePropertyAll(backgroundColor),
            foregroundColor: MaterialStatePropertyAll(white),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
            maximumSize: MaterialStatePropertyAll(
              Size(100, 50),
            )),
      ),
    );
  }
}

class EnableIcobButton extends StatelessWidget {
  EnableIcobButton({
    super.key,
    this.onPress,
    required this.ch,
    required this.icon,
  });
  final void Function()? onPress;
  final Widget ch;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label: ch,
      onPressed: onPress,
      style: ElevatedButtonTheme.of(context).style,
    );
  }
}

class disableButton extends StatelessWidget {
  disableButton({
    super.key,
    this.onPress,
    required this.ch,
  });
  final void Function()? onPress;
  final Widget? ch;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: ch,
      style: ElevatedButtonTheme.of(context).style!.copyWith(
            backgroundColor: MaterialStateProperty.all(
              green,
            ),
            foregroundColor: MaterialStateProperty.all(white),
          ),
    );
  }
}

class disableIconButton extends StatelessWidget {
  disableIconButton({
    super.key,
    this.onPress,
    required this.ch,
    required this.icon,
  });
  final void Function()? onPress;
  final Widget ch;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label: ch,
      onPressed: onPress,
      style: ElevatedButtonTheme.of(context).style!.copyWith(
            backgroundColor: MaterialStateProperty.all(
              pink,
            ),
            foregroundColor: MaterialStateProperty.all(white),
          ),
    );
  }
}

class urlButton extends StatelessWidget {
  urlButton({
    super.key,
    this.onPress,
    required this.icon,
    required this.ch,
  });
  final void Function()? onPress;

  final Widget icon;
  final String ch;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label: Text(
        ch,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: green),
      ),
      onPressed: onPress,
      style: ElevatedButtonTheme.of(context).style!.copyWith(
            backgroundColor: MaterialStateProperty.all(green_shade),
            foregroundColor: MaterialStateProperty.all(green),
          ),
    );
  }
}
