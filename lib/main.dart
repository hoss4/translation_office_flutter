import 'package:flutter/material.dart';
import 'package:translation_office_flutter/pages/addinfo.dart';
import 'package:translation_office_flutter/pages/book_app.dart';
import 'package:translation_office_flutter/pages/home.dart';
import 'package:translation_office_flutter/pages/login_page.dart';
import 'package:translation_office_flutter/pages/sign_up_page.dart';
import 'package:translation_office_flutter/pages/signin.dart';
import 'package:translation_office_flutter/pages/signup.dart';
import 'package:translation_office_flutter/pages/profile.dart';
import 'package:translation_office_flutter/pages/create_user.dart';
import 'package:translation_office_flutter/services/shared_service.dart';
import 'package:translation_office_flutter/pages/home_page.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const HomePage();
  }
  runApp(MaterialApp(
    routes: {
      '/Home': (context) => Home(),
      '/Signup': (context) => SignUP(),
      '/sign': (context) => SignIn(),
      '/info': (context) => AddInfo(),
      '/profile': (context) => Profile(),
      '/createuser': (context) => CreateUser(),
      '/booku': (context) => BookApp(),
      '/register': (context) => SignUpPage(),
      '/login': (context) => LoginPage(),
      '/': (context) => _defaultHome,
      '/home': (context) => HomePage(),
    },
  ));
}
