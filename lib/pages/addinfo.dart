import 'package:flutter/material.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({super.key});

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AddInfo",
        ),
      ),
      body: Text(
        "AddInfo Page",
      ),
    );
  }
}
