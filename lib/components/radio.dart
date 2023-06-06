// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unnecessary_this, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class RadioButtonGroupWidget extends StatefulWidget {
  final Function(String item) change;
  RadioButtonGroupWidget({required this.change});
  @override
  _RadioButtonGroupWidgetState createState() => _RadioButtonGroupWidgetState();
}

class _RadioButtonGroupWidgetState extends State<RadioButtonGroupWidget> {
  static const values = <String>['on the phone', 'in person'];
  String selectedValue = values.first;

  // final Color selectedColor = Colors.blue;
  final Color unselectedColor = Colors.black;

  @override
  Widget build(BuildContext context) => Container(
        //color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'pick your prefered way of communication :',
                style: TextStyle(
                  fontSize: 17,
                  // fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Divider(color: Colors.white),
            buildRadios(),
            Divider(color: Colors.white),
          ],
        ),
      );

  Widget buildRadios() => Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.black,
        ),
        child: Column(
          children: values.map(
            (value) {
              final selected = this.selectedValue == value;
              final color = selected ? Colors.blue : Colors.black;

              return RadioListTile<String>(
                value: value,
                groupValue: selectedValue,
                title: Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 17,
                  ),
                ),
                activeColor: Colors.blue,
                onChanged: (value) => setState(() {
                  selectedValue = value!;
                  widget.change(value);
                }),
              );
            },
          ).toList(),
        ),
      );
}
