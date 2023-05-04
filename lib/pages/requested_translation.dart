import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/models/login_response_model.dart';
import 'package:translation_office_flutter/models/translation_request.dart';
import 'package:translation_office_flutter/services/client_api.dart';
import '../components/navigation_drawer.dart';

class RequestedTranslations extends StatefulWidget {
  const RequestedTranslations({super.key});

  @override
  State<RequestedTranslations> createState() => _RequestedTranslationsState();
}

class _RequestedTranslationsState extends State<RequestedTranslations> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Requested Translations "),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
          future: ClientApi.getRequestedTranslations(),
          builder: (context, AsyncSnapshot snapshot) {
            ;
            if (snapshot.hasError) {
              return Center(
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
                    DateTime time =
                        DateTime.parse(snapshot.data![index]['time']);
                    DateTime newtime =
                        DateTime(0, 0, 0, time.hour + 2, time.minute);
                    bool onthephone = snapshot.data![index]['onthephone'];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 3),
                        child: ListTile(
                          leading: onthephone
                              ? Column(
                                  children: [
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
                                  children: [
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
                            child: Text('From ${fromlang} To ${tolang}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                          subtitle: Text(
                              ' ${date.day}/${date.month}/${date.year}  ${newtime.hour}:${newtime.minute}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          trailing: IconButton(
                              icon: Icon(
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
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
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
            "Appointement has been succesfully removed",
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
