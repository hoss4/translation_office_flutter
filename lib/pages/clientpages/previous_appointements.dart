import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:translation_office_flutter/components/navigation_drawer.dart';
import 'package:translation_office_flutter/pages/clientpages/view_prev.dart';
import 'package:translation_office_flutter/services/client_api.dart';

class PreviousAppointements extends StatelessWidget {
  const PreviousAppointements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("Previous Appointements"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
          future: ClientApi.getpreviousTranslations(),
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
                    String translatorname =
                        snapshot.data![index]['translatorname'];
                    bool inperson = snapshot.data![index]['inperson'];

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
                              icon: Icon(
                                CupertinoIcons.arrow_right,
                                size: 30,
                                color: Colors.blue[500],
                              ),
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PrevRequestInfo(
                                          translatorname: translatorname,
                                          date: date,
                                          fromlang: fromlang,
                                          tolang: tolang,
                                          time: newtime,
                                          inperson: inperson,
                                          onthephone: onthephone,
                                        )));
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
}
