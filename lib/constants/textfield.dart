import 'constans.dart';
import 'package:flutter/material.dart';

class textField extends StatefulWidget {
  textField({
    required this.keybordType,
    this.obscureTex = false,
    this.visibleIcon = false,
    this.tittle,
    this.hint,
    this.controller,
    super.key,
    this.maxlength,
    this.isphone,
  });
  final int? maxlength;
  final bool? isphone;
  final String? tittle;
  final String? hint;
  bool obscureTex;
  final bool visibleIcon;
  final TextInputType keybordType;
  TextEditingController? controller;

  @override
  State<textField> createState() => _textFieldState();
}

class _textFieldState extends State<textField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.tittle == null
            ? SizedBox()
            : Text(
                widget.tittle!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 22,
                    ),
              ),
        Container(
          height: 55,
          child: TextField(
            maxLength: widget.maxlength,
            controller: widget.controller,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.center,
            enabled: true,
            obscureText: widget.obscureTex,
            keyboardType: widget.keybordType,
            decoration: InputDecoration(
                /* prefix: widget.isphone != null
                    ? widget.isphone == true
                        ? Text("+20")
                        : SizedBox()
                    : null,*/
                hintText: widget.hint,
                suffix: widget.isphone != null
                    ? widget.isphone == true
                        ? Text("""20+""")
                        : SizedBox()
                    : null,
                suffixIcon: widget.visibleIcon
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            widget.obscureTex = !widget.obscureTex;
                          });
                        },
                        icon: widget.obscureTex
                            ? Icon(Icons.visibility_outlined)
                            : Icon(Icons.visibility_off_outlined),
                      )
                    : null,
                filled: true,
                fillColor: white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Theme.of(context).colorScheme.primary))),
          ),
        ),
      ],
    );
  }
}

class textFieldAdd extends StatefulWidget {
  textFieldAdd({
    required this.keybordType,
    this.controller,
    this.obscureTex = false,
    this.visibleIcon = false,
    this.tittle,
    this.hint,
    super.key,
  });
  final String? tittle;
  final String? hint;
  bool obscureTex;
  final bool visibleIcon;
  final TextInputType keybordType;
  TextEditingController? controller;

  @override
  State<textFieldAdd> createState() => _textFieldAddState();
}

class _textFieldAddState extends State<textFieldAdd> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.tittle == null
            ? SizedBox()
            : Text(
                widget.tittle!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 22, color: green),
              ),
        Container(
          height: 55,
          child: TextField(
            controller: widget.controller,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.center,
            enabled: true,
            keyboardType: widget.keybordType,
            decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: widget.visibleIcon
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          widget.obscureTex = !widget.obscureTex;
                        });
                      },
                      icon: Icon(Icons.currency_pound_outlined))
                  : null,
              filled: true,
              fillColor: white,
              /* enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Theme.of(context).colorScheme.primary)
                       
                        
                        ) */
            ),
          ),
        ),
      ],
    );
  }
}
