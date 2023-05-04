// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/button_widget.dart';
import 'package:translation_office_flutter/components/dropdownlist.dart';
import 'package:translation_office_flutter/components/language_picker_widget.dart';
import 'package:translation_office_flutter/components/navigation_drawer.dart';
import 'package:translation_office_flutter/components/pick_time.dart';
import 'package:translation_office_flutter/components/radio.dart';
import 'package:translation_office_flutter/models/translation_request.dart';
import 'package:translation_office_flutter/services/client_api.dart';
import 'package:translation_office_flutter/utils.dart';

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
  int index = 0;
  String? fromlang = 'English';
  String? tolang = 'Arabic';
  String? value = 'on the phone';
  DateTime dateTime = DateTime.now();
  DateTime time = DateTime.now();

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var _selectedIndex = 1;
    print(value);
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text(
          "Book Appointement",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'Pleasse fill in all of the following fields :',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                'pick the language you want to translate from and to :',
                style: TextStyle(
                  fontSize: 17,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: DropDownList(
                languages: languages,
                lang: fromlang,
                labelname: 'from',
                change: (item) {
                  setState(() {
                    fromlang = item;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: DropDownList(
                languages: languages,
                lang: tolang,
                labelname: 'to',
                change: (item) {
                  setState(() {
                    tolang = item;
                  });
                },
              ),
            ),
            Divider(
              color: Colors.black,
              height: 60,
              thickness: 1.2,
              indent: 30,
              endIndent: 30,
            ),
            RadioButtonGroupWidget(
              change: (item) {
                setState(() {
                  value = item;
                });
              },
            ),
            Divider(
              color: Colors.black,
              height: 60,
              thickness: 1.2,
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'pick the date and time of the appointment :',
                style: TextStyle(
                  fontSize: 17,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: ButtonWidget(
                dateTime: dateTime,
                onClicked: () => Utils.showSheet(
                  context,
                  child: buildDatePicker(),
                  onClicked: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: TimePicker(
                dateTime: time,
                onClicked: () => Utils.showSheet(
                  context,
                  child: buildTimePicker(),
                  onClicked: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  var onthePhone = false;
                  var inperson = false;
                  if (value == 'on the phone') {
                    onthePhone = true;
                  } else if (value == 'in person') {
                    inperson = true;
                  }

                  TranslationRequest request = TranslationRequest(
                    fromlanguage: fromlang,
                    tolanguage: tolang,
                    date: dateTime,
                    time: time,
                    onthephone: onthePhone,
                    inperson: inperson,
                  );

                  var response = await ClientApi.create_req(request);

                  if (response['status'] == '200') {
                    showCupertinoDialog(
                      context: context,
                      builder: createDialog,
                    );
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) =>
                          failureDialog(context, response['message']),
                    );
                  }
                },
                child: Text('confirm'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumDate: DateTime.now(),
          initialDateTime: DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          minimumYear: DateTime.now().year,
          maximumYear: DateTime.now().year + 5,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  Widget buildTimePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (time) => setState(() => this.time = time),
        ),
      );

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
          title: Text(
            "Success",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: Text(
            "Your request had been submitted successfully",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: Text("Done"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]);

  Widget failureDialog(BuildContext context, String message) =>
      CupertinoAlertDialog(
          title: Text(
            "Error",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: Text(
            "$message",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: Text("Done"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]);
}
