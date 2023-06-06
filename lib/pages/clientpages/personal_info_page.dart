// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:translation_office_flutter/components/navigation_drawer.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Information Page"),
        centerTitle: true,
      ),
    );
  }
}
