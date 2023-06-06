// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/services/client_api.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var oldpasswordController = TextEditingController();
  var newpassword2Controller = TextEditingController();
  var newpasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "please provide your old password and new password : ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: oldpasswordController,
                    obscureText: false,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Old Password',
                      prefixIcon: Icon(Icons.history_outlined),
                    ),
                    validator: (pass) {
                      if (pass!.isEmpty) {
                        return "Please enter old password";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: newpasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                      prefixIcon: Icon(Icons.security),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              hidePassword = !hidePassword;
                            },
                          );
                        },
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: (password) {
                      if (password!.isEmpty) {
                        return "Please enter new password";
                      }

                      if (password.length < 8) {
                        return "Password should be at least 8 characters";
                      }
                      if (!password.contains(RegExp(r'[A-Z]'))) {
                        return "Password should contain at least one uppercase letter";
                      }
                      if (!password.contains(RegExp(r'[a-z]'))) {
                        return "Password should contain at least one lowercase letter";
                      }
                      if (!password.contains(RegExp(r'[0-9]'))) {
                        return "Password should contain at least one number";
                      }
                      if (!password
                          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return "Password should contain at least one special character";
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: newpassword2Controller,
                    obscureText: hidePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Re-Write New Password',
                      prefixIcon: Icon(Icons.security),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              hidePassword = !hidePassword;
                            },
                          );
                        },
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: (password) {
                      if (password!.isEmpty) {
                        return "Please enter new password";
                      }
                      if (password != newpasswordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: CupertinoButton.filled(
                    onPressed: () async {
                      final form = formKey.currentState!;
                      if (form.validate()) {
                        var res = await ClientApi.resetpass(
                            oldpasswordController.text,
                            newpasswordController.text);

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
                      }
                    },
                    child: Text(
                      "Reset Password",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
          title: Text(
            "Success",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: Text(
            "Your password has been updated successfully",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: Text("Done"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]);

  Widget failureDialog(BuildContext context, String message) =>
      CupertinoAlertDialog(
          title: Text(
            "Error",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: Text("Done"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]);
}
