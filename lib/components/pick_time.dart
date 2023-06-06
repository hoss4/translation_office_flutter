import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatelessWidget {
  final VoidCallback onClicked;
  final DateTime dateTime;

  const TimePicker({
    Key? key,
    required this.onClicked,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 42),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.blue, width: 4),
        ),
        onPressed: onClicked,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.more_time, size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Pick a Time',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                " ${DateFormat.jm().format(dateTime)}",
                style: const TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      );
}
