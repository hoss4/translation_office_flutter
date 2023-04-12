// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/dropdownlist.dart';
import 'package:translation_office_flutter/components/radio.dart';
import 'package:translation_office_flutter/services/client_api.dart';

class BookApp extends StatefulWidget {
  const BookApp({super.key});

  @override
  State<BookApp> createState() => _BookAppState();
}

class _BookAppState extends State<BookApp> {
  @override
  List<String> languages = [
    "English",
    "Arabic",
    "German",
    "French",
    "Spanish",
  ];
  String? fromlang = 'English';
  String? tolang = 'Arabic';
  String? value = '';
  DateTime dateTime = DateTime.now();

  Widget build(BuildContext context) {
    var _selectedIndex = 1;
    print(dateTime);
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointement"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropDownList(
              languages: languages,
              lang: fromlang,
              labelname: 'from',
              change: (item) {
                setState(() {
                  fromlang = item;
                });
              },
            ),
            DropDownList(
              languages: languages,
              lang: tolang,
              labelname: 'to',
              change: (item) {
                setState(() {
                  tolang = item;
                });
              },
            ),
            RadioButtonGroupWidget(
              change: (item) {
                setState(() {
                  value = item;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 80,
              child: ElevatedButton(
                onPressed: () async {
                  final date = await pickDate(context, dateTime);
                  if (date == null) {
                    return;
                  }
                  setState(() {
                    dateTime = date;
                  });
                },
                child: Text(
                  "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                var onthePhone = false;
                var inperson = false;
                if (value == 'on the phone') {
                  onthePhone = true;
                } else if (value == 'in person') {
                  inperson = true;
                }
                var id = '642974f6ef18b7823cbae5f9';
                Map data = {
                  'from': fromlang,
                  'to': tolang,
                  'date': dateTime.toString(),
                  'type': value,
                  'onthePhone': onthePhone.toString(),
                  'inperson': inperson.toString(),
                };
                ClientApi.create_req(id, data);
              },
              child: Text('confirm'),
            )
          ],
        ),
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
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }
}

Future<DateTime?> pickDate(context, dateTime) => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
