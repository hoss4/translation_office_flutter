import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/navigation_drawer.dart';

class UpcomingAppointements extends StatelessWidget {
  const UpcomingAppointements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Upcoming app "),
      ),
    );
    ;
  }
}
