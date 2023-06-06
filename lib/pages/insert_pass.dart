// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/pages/login_page.dart';
import 'package:translation_office_flutter/services/api_service.dart';

// ignore: must_be_immutable
class PasswordReset extends StatefulWidget {
  PasswordReset({required this.type, required this.email, super.key});
  String type;
  String email;

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  var password1Controller = TextEditingController();
  var password2Controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "please insert your new password : ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: password1Controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'New Password',
                      prefixIcon: const Icon(Icons.security),
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
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: password2Controller,
                    obscureText: hidePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Re-Write New Password',
                      prefixIcon: const Icon(Icons.security),
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
                      if (password != password1Controller.text) {
                        return "Passwords do not match";
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
                        var response = await APIService.changepassword(
                            password1Controller.text,
                            widget.email,
                            widget.type);

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
          title: const Text(
            "Success",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: const Text(
            "Your password has been updated successfully",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("Done"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
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
