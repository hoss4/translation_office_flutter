import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:translation_office_flutter/services/api_service.dart';
import 'package:translation_office_flutter/services/shared_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
      body: userProfile(),
    );
  }

  Widget userProfile() {
    return FutureBuilder(
      future: APIService.getUserProfile(),
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
