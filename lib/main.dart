import 'package:flutter/material.dart';
import 'package:translation_office_flutter/pages/admin_home_page.dart';
import 'package:translation_office_flutter/pages/book_app.dart';
import 'package:translation_office_flutter/pages/login_page.dart';
import 'package:translation_office_flutter/pages/sign_up_page.dart';
import 'package:translation_office_flutter/pages/profile.dart';
import 'package:translation_office_flutter/pages/create_user.dart';
import 'package:translation_office_flutter/pages/translator_home_page.dart';
import 'package:translation_office_flutter/services/shared_service.dart';
import 'package:translation_office_flutter/pages/client_home_page.dart';

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
        '/profile': (context) => Profile(),
        '/createuser': (context) => CreateUser(),
        '/booku': (context) => BookApp(),
        '/register': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/': (context) => _defaultHome,
        '/clienthome': (context) => ClientHomePage(),
        '/transhome': (context) => TranslatorHomePage(),
        '/adminhome': (context) => AdminHomePage(),
      },
    ),
  );
}
