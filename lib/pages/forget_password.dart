// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/pages/change_pass.dart';

import '../services/api_service.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "please provide your Username and Email : ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: usernameController,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (username) {
                    if (username!.isEmpty) {
                      return "Please enter your username";
                    }
                    List user = username.split(".");
                    if (user.length != 2 &&
                        (user[0] != "translator" ||
                            user[0] != "client" ||
                            user[0] != "admin")) {
                      return "invalid username format";
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (email) {
                    if (email!.isEmpty) {
                      return "Please enter Your Email";
                    }
                    if (!EmailValidator.validate(email)) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: CupertinoButton.filled(
                  onPressed: () async {
                    final form = formKey.currentState!;
                    if (form.validate()) {
                      var response = await APIService.resetpassword(
                          usernameController.text, emailController.text);
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
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              )
            ],
          ),
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
            "Please check your email for the reset password code",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("done"),
                onPressed: () {
                  List user = usernameController.text.split(".");
                  String userType = user[0];

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ChangePassword(
                            type: userType,
                            email: emailController.text,
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
