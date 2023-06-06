// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/admin_naviagtor.dart';
import 'package:translation_office_flutter/models/register_request_model.dart';
import 'package:translation_office_flutter/services/admin_api.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  var usernameController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var ausernameController = TextEditingController();
  var anameController = TextEditingController();
  var aemailController = TextEditingController();
  var apasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final aformKey = GlobalKey<FormState>();

  List user = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        drawer: const AdminNaviagtor(),
        appBar: AppBar(
          title: const Text(
            "Create User",
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Create Translator",
              ),
              Tab(
                text: "Create Admin",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            translatorpage(),
            adminpage(),
          ],
        ),
      ),
    );
  }

  Widget translatorpage() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
              child: Text(
                "Please fill the following fields : ",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              header: const Text("Account Details"),
              children: [
                CupertinoFormRow(
                  prefix: const Text("Username"),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter Username',
                    textInputAction: TextInputAction.next,
                    controller: usernameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (username) {
                      if (username!.isEmpty) {
                        return "Please enter username";
                      }
                      user = username.split(".");
                      if (user.length != 2 || user[0] != "translator") {
                        return " username should be in the format of translator._____ , ex: translator.john12";
                      }

                      return null;
                    },
                  ),
                ),
                CupertinoFormRow(
                  prefix: const Text("Password"),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter Password',
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (password) {
                      if (password!.isEmpty) {
                        return "Please enter password";
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
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              thickness: 1.2,
              endIndent: 20,
              indent: 20,
            ),
            CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              header: const Text("User Information"),
              children: [
                CupertinoFormRow(
                  prefix: const Text("Email"),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter Email',
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "Please enter email";
                      }
                      if (!EmailValidator.validate(email)) {
                        return "Please enter valid email";
                      }

                      return null;
                    },
                  ),
                ),
                CupertinoFormRow(
                  prefix: const Text("Name"),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter Name',
                    controller: nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (name) {
                      if (name!.isEmpty) {
                        return "Please enter name";
                      }

                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: CupertinoButton.filled(
                child: const Text("Create"),
                onPressed: () async {
                  final form = formKey.currentState!;
                  if (form.validate()) {
                    RegisterRequestModel registerRequestModel =
                        RegisterRequestModel(
                            username: usernameController.text,
                            password: passwordController.text,
                            email: emailController.text,
                            name: nameController.text);
                    var response =
                        await AdminApi.createtranslator(registerRequestModel);
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget adminpage() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: aformKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
              child: Text(
                "Please fill the following fields : ",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              header: const Text("Account Details"),
              children: [
                CupertinoFormRow(
                  prefix: const Text("Username"),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter Username',
                    textInputAction: TextInputAction.next,
                    controller: ausernameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (username) {
                      if (username!.isEmpty) {
                        return "Please enter username";
                      }
                      user = username.split(".");
                      if (user.length != 2 || user[0] != "admin") {
                        return " username should be in the format of admin._____ , ex: admin.john12";
                      }

                      return null;
                    },
                  ),
                ),
                CupertinoFormRow(
                  prefix: const Text("Password"),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter Password',
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    controller: apasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (password) {
                      if (password!.isEmpty) {
                        return "Please enter password";
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
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              thickness: 1.2,
              endIndent: 20,
              indent: 20,
            ),
            CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              header: const Text("User Information"),
              children: [
                CupertinoFormRow(
                  prefix: const Text("Email"),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter Email',
                    controller: aemailController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "Please enter email";
                      }
                      if (!EmailValidator.validate(email)) {
                        return "Please enter valid email";
                      }

                      return null;
                    },
                  ),
                ),
                CupertinoFormRow(
                  prefix: const Text("Name"),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter Name',
                    controller: anameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (name) {
                      if (name!.isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: CupertinoButton.filled(
                child: const Text("Create"),
                onPressed: () async {
                  final form = aformKey.currentState!;
                  if (form.validate()) {
                    RegisterRequestModel registerRequestModel =
                        RegisterRequestModel(
                            username: ausernameController.text,
                            password: apasswordController.text,
                            email: aemailController.text,
                            name: anameController.text);
                    var response =
                        await AdminApi.createadmin(registerRequestModel);
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
              ),
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
            "User has been successfully created",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("done"),
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
