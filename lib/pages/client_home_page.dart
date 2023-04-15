import 'package:flutter/material.dart';
import 'package:translation_office_flutter/services/api_service.dart';
import 'package:translation_office_flutter/services/shared_service.dart';
import 'package:translation_office_flutter/components/navigation_drawer.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
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
      // body: userProfile(),
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
