// ignore_for_file: use_build_context_synchronously, must_be_immutable, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:translation_office_flutter/pages/insert_pass.dart';
import 'package:translation_office_flutter/services/api_service.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({required this.type, required this.email, super.key});
  String type;
  String email;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String resetcode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm code"),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'Please insert the code recieved on your email :',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: PinFieldAutoFill(
                currentCode: resetcode,
                onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  if (code!.length == 8) {
                    setState(() {
                      resetcode = code;
                    });
                  }
                },
                codeLength: 8,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: CupertinoButton.filled(
                child: const Text("Submit"),
                onPressed: () async {
                  var response = await APIService.confirmpin(
                      resetcode, widget.email, widget.type);
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
              ),
            ),
          ]),
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
            "Inserted code is correct, please insert your new password ",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("Done"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PasswordReset(
                            type: widget.type,
                            email: widget.email,
                          )));
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
