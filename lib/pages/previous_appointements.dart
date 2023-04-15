import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/navigation_drawer.dart';

class PreviousAppointements extends StatelessWidget {
  const PreviousAppointements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("previous app "),
      ),
    );
  }
}
