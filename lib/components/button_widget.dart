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
                  Icon(Icons.calendar_month, size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Pick a date',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text("${dateTime.day}/${dateTime.month}/${dateTime.year}",
                  style: const TextStyle(fontSize: 25)),
            ],
          ),
        ),
      );
}
