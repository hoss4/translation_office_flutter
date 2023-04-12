import 'package:flutter/material.dart';

import 'package:mongo_dart/mongo_dart.dart' as M;

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
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
                      labelText: 'Email',
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
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                // adduser(nameController.text, emailController.text,
                //     passwordController.text);
                // Navigator.pushReplacementNamed(context, '/Home');
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
    ;
  }

  // Future<void> adduser(String name, String email, String password) async {
  //   var _id = M.ObjectId();
  //   final data = Translator(
  //     id: _id,
  //     name: name,
  //     email: email,
  //     password: password,
  //     languages: [],
  //   );

  //   var result = await Translator.insert(data);
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text("inserted id" + _id.$oid)));
  //   clearAll();
  // }

  void clearAll() {
    emailController.text = '';
    passwordController.text = '';
    nameController.text = '';
  }
}
