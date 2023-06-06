// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:translation_office_flutter/pages/adminpages/view_appsad.dart';
import 'package:translation_office_flutter/services/admin_api.dart';

// ignore: must_be_immutable
class UpcomingAppInfo extends StatefulWidget {
  String translationid;
  DateTime createdat;
  DateTime acceptedat;
  String clientname;
  String translatorname;
  String fromlang;
  String tolang;
  DateTime date;
  DateTime time;
  bool onthephone;
  bool inperson;
  UpcomingAppInfo({
    required this.clientname,
    required this.fromlang,
    required this.tolang,
    required this.date,
    required this.time,
    required this.onthephone,
    required this.inperson,
    required this.translationid,
    required this.createdat,
    required this.acceptedat,
    required this.translatorname,
    super.key,
  });

  @override
  State<UpcomingAppInfo> createState() => _UpcomingAppInfoState();
}

class _UpcomingAppInfoState extends State<UpcomingAppInfo> {
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
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
              ),
              child: Text("Request Details",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline)),
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
                "Created At : ${widget.createdat.day}/${widget.createdat.month}/${widget.createdat.year}  ${DateFormat.jm().format(widget.createdat)}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30,
              ),
              child: Text(
                "Accepted At : ${widget.acceptedat.day}/${widget.acceptedat.month}/${widget.acceptedat.year}  ${DateFormat.jm().format(widget.acceptedat)}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Divider(
              height: 60,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
              ),
              child: Text(
                "Appointement Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
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
                "Status :  Accepted",
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
            Center(
              child: CupertinoButton(
                onPressed: () async {
                  var res =
                      await AdminApi.cancelAppointement(widget.translationid);
                  if (res['status'] == '200') {
                    showCupertinoDialog(
                      context: context,
                      builder: createDialog,
                    );
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) =>
                          failureDialog(context, res['message']),
                    );
                  }
                },
                color: Colors.red,
                child: const Text("Cancel Appointement"),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
          title: const Text(
            "Success",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: const Text(
            "Appointement has been succesfully removed",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("Done"),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ViewAppA()));
                })
          ]);

  Widget failureDialog(BuildContext context, String message) =>
      CupertinoAlertDialog(
          title: const Text(
            "Error",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("Done"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]);
}
