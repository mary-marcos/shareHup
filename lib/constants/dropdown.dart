import 'constans.dart';

import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  DropDownButton(
      {required this.selectedOption,
      required this.options,
      super.key,
      required this.onChanged});
  String selectedOption;
  final List<String> options;
  void Function(String) onChanged;

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 55,
          width: 200,
          decoration: BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(color: green_shade, width: 2)),
              color: white,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              DropdownButton<String>(
                onTap: () {},
                focusColor: white,
                dropdownColor: white,
                style: TextStyle(color: black),
                value: widget.selectedOption,
                hint: Text('Select an option'),
                icon: Icon(Icons.keyboard_arrow_down_sharp),
                onChanged: (newValue) {
                  setState(() {
                    widget.selectedOption = newValue!;
                  });
                  // Call the onChanged callback with the new value
                  widget.onChanged(newValue!);
                },

                /*(String? newValue) {
                            setState(() {
                              selectedOption = newValue!;
                            });
                          },*/
                items: widget.options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              ),

              /* Text(
                          'Selected Option: $selectedOption',
                          style: TextStyle(fontSize: 20.0),
                        ),*/
            ],
          ),
        ),
      ],
    );
  }
}
