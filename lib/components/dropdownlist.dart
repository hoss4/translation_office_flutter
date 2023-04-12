import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  List<String>? languages;
  String? lang;
  String? labelname;

  final Function(String item) change;
  DropDownList(
      {this.languages, this.lang, this.labelname, required this.change});

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 80,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.blue),
            borderRadius: BorderRadius.circular(16),
          ),
          labelText: widget.labelname,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        items: widget.languages!
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
            .toList(),
        value: widget.lang,
        onChanged: (item) {
          setState(() {
            widget.lang = item;
            widget.change(item!);
          });
        },
      ),
    );
  }
}
