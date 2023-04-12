import 'package:flutter/material.dart';
import 'package:translation_office_flutter/models/client.dart';
import 'package:translation_office_flutter/pages/profile.dart';
//import 'package:mongo_dart/mongo_dart.dart';

class Home extends StatefulWidget {
  Client? client;
  Home({this.client});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    //nameController.text = widget.client!.name.toString();
    //backupemailController.text = widget.client!.backupemail.toString();
    passwordController.text = widget.client!.password.toString();
    emailController.text = widget.client!.email.toString();
  }

  Map data = {};
  int _selectedIndex = 0;
  static TextStyle optionStyle =
      // ignore: prefer_const_constructors
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Map data = {};
  @override
  Widget build(BuildContext context) {
    //data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation office'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Book appointment',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
