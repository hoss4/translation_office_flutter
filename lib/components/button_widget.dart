import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final DateTime dateTime;

  const ButtonWidget({
    Key? key,
    required this.onClicked,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size(100, 42)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_month, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Pick a date',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text("${dateTime.day}/${dateTime.month}/${dateTime.year}",
                  style: TextStyle(fontSize: 25)),
            ],
          ),
        ),
        onPressed: onClicked,
      );
}
