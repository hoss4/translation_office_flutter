// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/admin_naviagtor.dart';
import 'package:translation_office_flutter/components/refresh_widget.dart';
import 'package:translation_office_flutter/models/admin.dart';
import 'package:translation_office_flutter/pages/adminpages/resetpass.dart';
import 'package:translation_office_flutter/services/admin_api.dart';
import 'package:translation_office_flutter/services/shared_service.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool readonly = true;
  Color color = Colors.white;
  var usernameController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminNaviagtor(),
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 30,
              color: color,
            ),
            onPressed: () {
              setState(() {
                readonly = !readonly;
                if (readonly) {
                  color = Colors.white;
                } else {
                  color = Colors.black;
                }
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: RefreshWidget(
        onRefresh: () async {
          setState(() {});
        },
        child: userProfile(),
      ),
    );
  }

  Widget userProfile() {
    return FutureBuilder(
      future: AdminApi.getadmin(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['status'] == '403') {
            SharedService.logout(context);
          }
          Map res = jsonDecode(snapshot.data!['data']);
          emailController.text = res['email'];
          usernameController.text = res['username'];
          nameController.text = res['name'];
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: TextFormField(
                      controller: usernameController,
                      obscureText: false,
                      readOnly: readonly,
                      enabled: !readonly,
                      style: TextStyle(
                        color: readonly ? Colors.grey : Colors.black,
                      ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (username) {
                        if (username!.isEmpty) {
                          return "Please enter username";
                        }
                        List user = username.split(".");
                        if (user.length != 2 || user[0] != "admin") {
                          return " username should be in the format of admin.";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          icon: Icon(Icons.person)),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: nameController,
                      obscureText: false,
                      readOnly: readonly,
                      enabled: !readonly,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                          color: readonly ? Colors.grey : Colors.black),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return "Please enter name";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          icon: Icon(Icons.abc)),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: emailController,
                      obscureText: false,
                      style: TextStyle(
                          color: readonly ? Colors.grey : Colors.black),
                      readOnly: readonly,
                      enabled: !readonly,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Please enter email";
                        }
                        if (!EmailValidator.validate(email)) {
                          return "Please enter valid email";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          icon: Icon(Icons.email)),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () async {
                      final form = formKey.currentState!;
                      if (form.validate()) {
                        Admin admin = Admin(
                            email: emailController.text,
                            username: usernameController.text,
                            name: nameController.text);

                        var response = await AdminApi.updateadmin(admin);

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
                    child: const Text("Save Changes",
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ResetPasswordPage(),
                      ));
                    },
                    child: const Text(
                      "Change Password",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      SharedService.logout(context);
                    },
                    child: const Text("Log out",
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
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
            "Your profile has been updated successfully",
            style: TextStyle(
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
