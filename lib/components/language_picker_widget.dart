import 'package:flutter/material.dart';

class PickerWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final String? lang;

  const PickerWidget({
    Key? key,
    required this.onClicked,
    required this.lang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 90,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(100, 42),
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            side: BorderSide(color: Colors.blue, width: 3),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 8),
                      Text(
                        'From',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Text(lang!,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(width: 80),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.grey,
                    )
                  ],
                ),
              ],
            ),
          ),
          onPressed: onClicked,
        ),
      );
}
