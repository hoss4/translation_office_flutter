// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:translation_office_flutter/pages/adminpages/admin_home_page.dart';
import 'package:translation_office_flutter/pages/login_page.dart';
import 'package:translation_office_flutter/pages/sign_up_page.dart';
import 'package:translation_office_flutter/pages/translatorpages/translator_home_page.dart';
import 'package:translation_office_flutter/services/shared_service.dart';
import 'package:translation_office_flutter/pages/clientpages/client_home_page.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    var loginDetails = await SharedService.loginDetails();
    String type = loginDetails!.data!.type;
    switch (type) {
      case "client":
        _defaultHome = const ClientHomePage();
        break;
      case "translator":
        _defaultHome = const TranslatorHomePage();
        break;
      case "admin":
        _defaultHome = const AdminHomePage();
        break;
    }
  }
  runApp(
    MaterialApp(
      routes: {
        '/register': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
        '/': (context) => _defaultHome,
        '/clienthome': (context) => const ClientHomePage(),
        '/transhome': (context) => const TranslatorHomePage(),
        '/adminhome': (context) => const AdminHomePage(),
      },
    ),
  );
}
