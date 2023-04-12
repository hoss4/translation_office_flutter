import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  @override
  State<DateTimePicker> createState() => _DateTimePickertState();
}

class _DateTimePickertState extends State<DateTimePicker> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date Time Picker"),
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final date = await pickDate(context);
                  if (date == null) {
                    return;
                  }
                  setState(() {
                    dateTime = date;
                  });
                },
                child: Text(
                  "${dateTime.year}/${dateTime.month}/${dateTime.day}",
                ),
              )
            ],
          )),
    );
  }
}

Future<DateTime?> pickDate(context) => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
