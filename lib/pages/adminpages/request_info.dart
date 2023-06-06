// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/models/trans.dart';
import 'package:translation_office_flutter/pages/adminpages/view_requests.dart';
import 'package:translation_office_flutter/services/admin_api.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class RequestInfo extends StatefulWidget {
  String translationid;
  String clientname;
  String fromlang;
  String tolang;
  DateTime date;
  DateTime time;
  bool onthephone;
  bool inperson;
  DateTime createdat;
  RequestInfo(
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
  State<RequestInfo> createState() => _RequestInfoState();
}

class _RequestInfoState extends State<RequestInfo> {
  List<Trans> translators = [];
  Trans selectedTranslator = Trans();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Info"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
          future: AdminApi.getTranslators(widget.fromlang, widget.tolang),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            if (snapshot.hasData) {
              translators = snapshot.data!;
              // ignore: avoid_unnecessary_containers
              return Container(
                child: SingleChildScrollView(
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
                            "Status :  Pending assignment to a Translator",
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
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 20.0,
                          ),
                          child: Text("Pick a Translator",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ExpansionTile(
                          title: const Text(
                            "Available Translators",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          children: translators.map(
                            (value) {
                              // ignore: unnecessary_this
                              final selected = this.selectedTranslator == value;
                              final color =
                                  selected ? Colors.blue : Colors.black;

                              return RadioListTile<Trans>(
                                value: value,
                                groupValue: selectedTranslator,
                                title: Text(
                                  value.name!,
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 17,
                                  ),
                                ),
                                activeColor: Colors.blue,
                                onChanged: (value) => setState(() {
                                  selectedTranslator = value!;
                                }),
                              );
                            },
                          ).toList(),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Center(
                          child: CupertinoButton.filled(
                            child: const Text("Assign"),
                            onPressed: () async {
                              // ignore: unnecessary_null_comparison
                              if (selectedTranslator != null) {
                                var response = await AdminApi.assignTranslator(
                                    selectedTranslator.id!,
                                    widget.translationid);
                                if (response['status'] == '200') {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: createDialog,
                                  );
                                } else {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) => failureDialog(
                                        context, response['message']),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                      ]),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
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
            "Translation has been assigned successfully",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("done"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ViewRequest()));
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
