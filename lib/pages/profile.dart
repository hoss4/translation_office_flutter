// ignore_for_file: unnecessary_new, must_be_immutable

import 'package:flutter/material.dart';
import 'package:translation_office_flutter/models/client.dart';
import 'package:translation_office_flutter/services/client_api.dart';

class Profile extends StatefulWidget {
  Client? client;
  Profile({
    this.client,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var backupemailController = new TextEditingController();
  var nameController = new TextEditingController();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  String id = '';

  @override
  void initState() {
    super.initState();
    //nameController.text = widget.client!.name.toString();
    //backupemailController.text = widget.client!.backupemail.toString();
  }

  Widget build(BuildContext context) {
    var _selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ClientApi.getclient(),
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot.hasData);
            emailController.text = snapshot.data['email'];
            passwordController.text = snapshot.data['password'];
            backupemailController.text = snapshot.data['backupemail'];
            nameController.text = snapshot.data['name'];
            id = snapshot.data['_id'];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: TextField(
                            controller: emailController,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                                icon: Icon(Icons.abc)),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: TextField(
                            controller: passwordController,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                icon: Icon(Icons.security)),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: TextField(
                            controller: nameController,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'name',
                                icon: Icon(Icons.person)),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 65),
                          child: TextField(
                            controller: backupemailController,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'email',
                                icon: Icon(Icons.email)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Client client = new Client(
                                email: emailController.text,
                                username: backupemailController.text,
                                name: nameController.text);

                            ClientApi.updateclient(client);
                          },
                          child: Text("Save Changes",
                              style: TextStyle(
                                color: Colors.blue,
                              )),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Log out",
                              style: TextStyle(
                                color: Colors.red,
                              )),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Delete Account",
                              style: TextStyle(
                                color: Colors.red,
                              )),
                        ),
                      ]),
                );
              } else {
                return Center(
                  child: Text(
                    "Couldn't get Data",
                  ),
                );
              }
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Book appointment',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/booku');
          }
        },
      ),
    );
  }
}
