import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/admin_naviagtor.dart';
import 'package:translation_office_flutter/services/api_service.dart';
import 'package:translation_office_flutter/services/shared_service.dart';
import 'package:translation_office_flutter/components/navigation_drawer.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminNaviagtor(),
      appBar: AppBar(
        title: Text(" Admin Home"),
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
      // body: userProfile(),
    );
  }

  Widget userProfile() {
    return FutureBuilder(
      //future: APIService.getUserProfile(),
      builder: (BuildContext context, AsyncSnapshot<String> model) {
        if (model.hasData) {
          print("here---" + model.data!);
          return Center(
            child: Text(
              model.data!,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
