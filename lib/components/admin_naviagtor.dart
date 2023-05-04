import 'package:flutter/material.dart';
import 'package:translation_office_flutter/pages/admin_home_page.dart';

import 'package:translation_office_flutter/pages/translator_home_page.dart';
import 'package:translation_office_flutter/services/shared_service.dart';

class AdminNaviagtor extends StatelessWidget {
  const AdminNaviagtor({super.key});

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
              height: 70,
              thickness: 1.5,
            ),
            buildMenuItem(
              text: 'Create User',
              icon: Icons.person_add_alt_1_rounded,
              onClicked: () => SelectedItem(context, 2),
            ),
            SizedBox(
              height: 20,
            ),
            buildMenuItem(
              text: 'Appointement Requests',
              icon: Icons.app_registration_rounded,
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
    final color = Colors.white;
    double Size = 15;

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
          builder: (context) => AdminHomePage(),
        ));
        break;
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => InformationPage(),
        // ));
        break;
      case 2:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => BookApp(),
        // ));
        break;
    }
  }
}
