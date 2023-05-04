import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/refresh_widget.dart';
import 'package:translation_office_flutter/models/client.dart';
import 'package:translation_office_flutter/pages/changepassword.dart';
import 'dart:convert';
import 'package:translation_office_flutter/services/api_service.dart';
import 'package:translation_office_flutter/services/client_api.dart';
import 'package:translation_office_flutter/services/shared_service.dart';
import 'package:translation_office_flutter/components/navigation_drawer.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  bool readonly = true;
  Color color = Colors.black;
  var usernameController = new TextEditingController();
  var nameController = new TextEditingController();
  var emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                SharedService.logout(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
            )
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: RefreshWidget(
          onRefresh: () async {
            print("---------hello");
            setState(() {});
          },
          child: userProfile(),
        ));
  }

  Widget userProfile() {
    return FutureBuilder(
      future: ClientApi.getclient(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map res = jsonDecode(snapshot.data!);
          emailController.text = res['email'];
          usernameController.text = res['username'];
          nameController.text = res['name'];
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 30.0, top: 30, bottom: 50),
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 30,
                      color: color,
                    ),
                    onPressed: () {
                      setState(() {
                        readonly = !readonly;
                        if (readonly) {
                          color = Colors.black;
                        } else {
                          color = Colors.blue;
                        }
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: usernameController,
                  obscureText: false,
                  readOnly: readonly,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      icon: Icon(Icons.person)),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: nameController,
                  obscureText: false,
                  readOnly: readonly,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      icon: Icon(Icons.abc)),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  readOnly: readonly,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      icon: Icon(Icons.email)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () async {
                  Client client = new Client(
                      email: emailController.text,
                      username: usernameController.text,
                      name: nameController.text);

                  var response = await ClientApi.updateclient(client);

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
                child: Text("Save Changes",
                    style: TextStyle(
                      color: Colors.blue,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResetPasswordPage(),
                  ));
                },
                child: Text(
                  "Change Password",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  SharedService.logout(context);
                },
                child: Text("Log out",
                    style: TextStyle(
                      color: Colors.red,
                    )),
              ),
            ]),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
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
            "Your profile has been updated successfully",
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
            "$message",
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
