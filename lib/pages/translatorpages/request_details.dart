// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:translation_office_flutter/pages/translatorpages/trans_requests.dart';
import 'package:translation_office_flutter/services/translator_api.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class RequestDetails extends StatefulWidget {
  String translationid;
  String clientname;
  String fromlang;
  String tolang;
  DateTime date;
  DateTime time;
  bool onthephone;
  bool inperson;
  DateTime createdat;
  RequestDetails(
      {required this.translationid,
      required this.clientname,
      required this.fromlang,
      required this.tolang,
      required this.date,
      required this.time,
      required this.onthephone,
      required this.inperson,
      required this.createdat,
      super.key});

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Request Info"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    "Request Information",
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
                "Created At :  ${widget.createdat.day}/${widget.createdat.month}/${widget.createdat.year}  ${DateFormat.jm().format(widget.createdat)}",
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
              child: Text("Appointement Details",
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
                "Status :  Pending Approval",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Accept",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              confirmDialog(context));
                    }),
                const SizedBox(
                  width: 20,
                ),
                CupertinoButton(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.xmark,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Reject",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              rejectDialog(context));
                    }),
              ],
            ),
            const SizedBox(
              height: 65,
            ),
          ]),
        ));
  }

  Widget confirmDialog(BuildContext context) => CupertinoAlertDialog(
          title: const Text(
            "Confirm",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: const Text(
            "Are you sure you want to accept this request?",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("Yes"),
                onPressed: () async {
                  var response =
                      await TranslatorApi.acceptRequest(widget.translationid);
                  if (response['status'] == '200') {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ViewMyRequests()));
                    Fluttertoast.showToast(
                      msg: "Success : Request has been Accepted",
                      fontSize: 18,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 4,
                    );
                  } else {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: "Error : Request failed, please try again later ",
                      fontSize: 18,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 4,
                    );
                  }
                }),
            CupertinoDialogAction(
                child: const Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]);

  Widget rejectDialog(BuildContext context) => CupertinoAlertDialog(
          title: const Text(
            "Confirm",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: const Text(
            "Are you sure you want to reject this request?",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("Yes"),
                onPressed: () async {
                  var response =
                      await TranslatorApi.rejectRequest(widget.translationid);
                  if (response['status'] == '200') {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ViewMyRequests()));
                    Fluttertoast.showToast(
                      msg: "Success : Request has been Rejected",
                      fontSize: 18,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 4,
                    );
                  } else {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: "Error : Request failed, please try again later ",
                      fontSize: 18,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 4,
                    );
                  }
                }),
            CupertinoDialogAction(
                child: const Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]);
}
