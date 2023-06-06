// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/services/client_api.dart';
import '../../components/navigation_drawer.dart';
import 'package:intl/intl.dart';

class RequestedTranslations extends StatefulWidget {
  const RequestedTranslations({super.key});

  @override
  State<RequestedTranslations> createState() => _RequestedTranslationsState();
}

class _RequestedTranslationsState extends State<RequestedTranslations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("Requested Appointements"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
          future: ClientApi.getRequestedTranslations(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String fromlang = snapshot.data![index]['fromlang'];
                    String tolang = snapshot.data![index]['tolang'];
                    DateTime date =
                        DateTime.parse(snapshot.data![index]['date']);

                    DateTime newtime =
                        DateTime(0, 0, 0, date.hour + 2, date.minute);

                    bool onthephone = snapshot.data![index]['onthephone'];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 3),
                        child: ListTile(
                          leading: onthephone
                              ? Column(
                                  children: const [
                                    Icon(
                                      Icons.phone,
                                      size: 20,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'On the phone',
                                      style: TextStyle(fontSize: 9),
                                    )
                                  ],
                                )
                              : Column(
                                  children: const [
                                    Icon(Icons.people_alt_sharp),
                                    SizedBox(height: 8),
                                    Text(
                                      ' In person',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                          title: Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 10.0,
                            ),
                            child: Text('From $fromlang To $tolang',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                          subtitle: Text(
                              ' ${date.day}/${date.month}/${date.year}  ${DateFormat.jm().format(newtime)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          trailing: IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.red,
                                size: 30,
                              ),
                              onPressed: () async {
                                var response =
                                    await ClientApi.deleteTranslationRequest(
                                        snapshot.data![index]['_id']);

                                if (response['status'] == '200') {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: createDialog,
                                  );
                                } else {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) => failureDialog(
                                        context, response['message']),
                                  );
                                }
                                setState(() {
                                  snapshot.data!.removeAt(index);
                                });
                              }),
                          isThreeLine: true,
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
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
            "Appointement has been succesfully cancelled",
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
