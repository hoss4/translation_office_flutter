// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:translation_office_flutter/models/client.dart';
import 'package:translation_office_flutter/pages/profile.dart';
import 'package:translation_office_flutter/services/client_api.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  var backupemailController = new TextEditingController();
  var nameController = new TextEditingController();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Sign up",
          ),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: Image(
                image: AssetImage('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 55,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      icon: Icon(Icons.abc)),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: passwordController,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      icon: Icon(Icons.no_encryption)),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: nameController,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                      icon: Icon(Icons.person)),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: backupemailController,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      icon: Icon(Icons.email)),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () async {
                Client client = Client(
                  name: nameController.text,
                  backupemail: backupemailController.text,
                  password: passwordController.text,
                  email: emailController.text,
                );
                await ClientApi.create_client(client);
                Navigator.pushReplacementNamed(context, '/Home');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(
                        client: Client(
                      name: nameController.text,
                      backupemail: backupemailController.text,
                      password: passwordController.text,
                      email: emailController.text,
                    )),
                  ),
                );
              },
              child: Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ]),
        ));
  }

  void clearAll() {
    backupemailController.text = '';
    passwordController.text = '';
    nameController.text = '';
    emailController.text = '';
  }
}
