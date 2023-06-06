// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/refresh_widget.dart';
import 'package:translation_office_flutter/components/translator_navigator.dart';
import 'package:translation_office_flutter/models/translator.dart';
import 'package:translation_office_flutter/pages/translatorpages/reset_pass.dart';
import 'package:translation_office_flutter/pages/translatorpages/view_languages.dart';
import 'package:translation_office_flutter/services/shared_service.dart';
import 'package:translation_office_flutter/services/translator_api.dart';

class TranslatorHomePage extends StatefulWidget {
  const TranslatorHomePage({super.key});

  @override
  State<TranslatorHomePage> createState() => _TranslatorHomePageState();
}

class _TranslatorHomePageState extends State<TranslatorHomePage> {
  bool readonly = true;
  Color color = Colors.white;
  var usernameController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  List<dynamic> languages = [];
  String translatorid = "";
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const TranslatorNaviagtor(),
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
      future: TranslatorApi.gettranslator(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['status'] == '403') {
            SharedService.logout(context);
          }
          Map res = jsonDecode(snapshot.data!['data']);
          emailController.text = res['email'];
          usernameController.text = res['username'];
          nameController.text = res['name'];
          languages = res['languages'];
          translatorid = res['id'];

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: formKey,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                    enabled: !readonly,
                    readOnly: readonly,
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
                      if (user.length != 2 || user[0] != "translator") {
                        return " username should be in the format of translator.";
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
                    style:
                        TextStyle(color: readonly ? Colors.grey : Colors.black),
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
                    style:
                        TextStyle(color: readonly ? Colors.grey : Colors.black),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("View Languages"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewLangs(
                          languages: languages,
                          translatorid: translatorid,
                        ),
                      ));
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () async {
                    final form = formKey.currentState!;
                    if (form.validate()) {
                      Translator translator = Translator(
                          email: emailController.text,
                          username: usernameController.text,
                          name: nameController.text);

                      var response =
                          await TranslatorApi.updatetranslator(translator);

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
              ]),
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
