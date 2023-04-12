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

  final selectedColor = Colors.black;
  final unselectedColor = Colors.white;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56.0),
        child: Container(
          color: Colors.blue[500],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(color: Colors.white),
                buildRadios(),
                Divider(color: Colors.white),
              ],
            ),
          ),
        ),
      );

  Widget buildRadios() => Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: unselectedColor,
        ),
        child: Column(
          children: values.map(
            (value) {
              final selected = this.selectedValue == value;
              final color = selected ? selectedColor : unselectedColor;

              return RadioListTile<String>(
                value: value,
                groupValue: selectedValue,
                title: Text(
                  value,
                  style: TextStyle(color: color),
                ),
                activeColor: selectedColor,
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
