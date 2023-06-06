// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class OldAppInfo extends StatefulWidget {
  String translatorname;
  String clientname;
  String fromlang;
  String tolang;
  DateTime date;
  DateTime time;
  bool onthephone;
  bool inperson;

  OldAppInfo({
    required this.translatorname,
    required this.fromlang,
    required this.tolang,
    required this.date,
    required this.time,
    required this.onthephone,
    required this.inperson,
    required this.clientname,
    super.key,
  });

  @override
  State<OldAppInfo> createState() => _OldAppInfoState();
}

class _OldAppInfoState extends State<OldAppInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointement Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
                left: 20,
              ),
              child: Row(
                children: const [
                  Icon(
                    CupertinoIcons.doc_text_fill,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Appointement Details",
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 60,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30,
              ),
              child: Text(
                "Translator Name :  ${widget.translatorname}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30,
              ),
              child: Text(
                "Client Name :  ${widget.clientname}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30,
              ),
              child: Text(
                "From :  ${widget.fromlang}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30,
              ),
              child: Text(
                "To :  ${widget.tolang}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30,
              ),
              child: Text(
                "Date : ${widget.date.day}/${widget.date.month}/${widget.date.year} ",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30,
              ),
              child: Text(
                "Time :  ${DateFormat.jm().format(widget.time)}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30,
              ),
              child: Text(
                widget.onthephone
                    ? "Type :  On The Phone"
                    : "Type :  In Person",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30,
              ),
              child: Text(
                "Status :  Finished",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const Divider(
              height: 60,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
