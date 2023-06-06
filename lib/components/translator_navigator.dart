// ignore_for_file: prefer_const_constructors, constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:translation_office_flutter/pages/translatorpages/prev_app.dart';
import 'package:translation_office_flutter/pages/translatorpages/trans_requests.dart';

import 'package:translation_office_flutter/pages/translatorpages/translator_home_page.dart';
import 'package:translation_office_flutter/pages/translatorpages/view_upcomingapp.dart';
import 'package:translation_office_flutter/services/shared_service.dart';

class TranslatorNaviagtor extends StatelessWidget {
  const TranslatorNaviagtor({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            buildMenuItem(
              text: 'profile',
              icon: Icons.person,
              onClicked: () => SelectedItem(context, 0),
            ),
            Divider(
              color: Colors.white,
              height: 75,
              thickness: 1.5,
            ),
            buildMenuItem(
              text: 'Appointement Requests',
              icon: Icons.edit_calendar_outlined,
              onClicked: () => SelectedItem(context, 1),
            ),
            SizedBox(
              height: 20,
            ),
            buildMenuItem(
              text: 'Previous Appointements',
              icon: Icons.pending_actions_sharp,
              onClicked: () => SelectedItem(context, 2),
            ),
            SizedBox(
              height: 20,
            ),
            buildMenuItem(
              text: 'Upcoming Appointements',
              icon: Icons.people,
              onClicked: () => SelectedItem(context, 3),
            ),
            Divider(
              color: Colors.white,
              height: 75,
              thickness: 1.5,
            ),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.red[300],
                size: 30,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 18,
                ),
              ),
              onTap: () {
                SharedService.logout(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const double Size = 15;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 25,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: Size,
        ),
      ),
      onTap: onClicked,
    );
  }

  SelectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TranslatorHomePage(),
        ));
        break;

      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ViewMyRequests(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PrevApp(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UpcomingApp(),
        ));
        break;
    }
  }
}
