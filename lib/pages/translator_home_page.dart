import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/translator_navigator.dart';
import 'package:translation_office_flutter/services/api_service.dart';
import 'package:translation_office_flutter/services/shared_service.dart';
import 'package:translation_office_flutter/components/navigation_drawer.dart';

class TranslatorHomePage extends StatefulWidget {
  const TranslatorHomePage({super.key});

  @override
  State<TranslatorHomePage> createState() => _TranslatorHomePageState();
}

class _TranslatorHomePageState extends State<TranslatorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TranslatorNaviagtor(),

      appBar: AppBar(
        title: Text(" Translator Home"),
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
